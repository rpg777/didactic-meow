#!/usr/bin/ruby
# EnergyPlus roll-up tool
# place idfs in "in" directory; translation tools, report var csvs, and idds in cwd

require "FileUtils"

city = "Denver"

puts "City:\t#{city}"

models = Dir.glob("./in/*_#{city}.idf")

models.each do |model| 

    puts "Building type:\t'#{model.split('_')[1]}'"

    versions = Dir.glob('Transition-V*')

    versions.sort.each do |t|
        v_from = t.split('V')[1].split('-to-')[0]
        puts "Converting '#{model.split('_')[1]}' model: V-#{v_from} --> V-#{t.split('V')[2]}"
            
        # step through the transitions
        cmd =  "./Transition-V#{t.split('V')[1].split('-to-')[0]}-to-V#{t.split('V')[2]} #{model}"
        system(cmd)
        
    end

end
