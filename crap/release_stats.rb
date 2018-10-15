# release_stats.rb
# parse Radiance releases from NREL's GitHub Repo
# 2018.10.15 R. Guglielmetti
# https://api.github.com/repos/NREL/Radiance/releases
# TODO: work directly with wget data, eliminate temp file save/delete
# USAGE: ruby release_stats.rb

require 'json'
require 'open3'

tempdata = "z_release_tempdata"

stdout,stderr,status = Open3.capture3("wget https://api.github.com/repos/NREL/Radiance/releases --output-document=#{tempdata}")
STDERR.puts stderr
if status.success?

    file = File.read(tempdata)
    releases = JSON.parse(file)
    puts "#{releases.size} releases:"
    releases.each do |rel|

        dl = 0

        puts "Release: #{rel['name']} (published #{rel['published_at']})"
        puts "Downloads (asset name, download count):"
        rel['assets'].each do |a|
            dl += a['download_count']
            puts "\t#{a['name']}, #{a['download_count']}"
        end

        puts "\tTotal downloads: #{dl}"
        puts
    end

    puts "deleting tempfile '#{tempdata}'"
    File.delete(tempdata) 

else
  STDERR.puts "Error downloading stats"
end
