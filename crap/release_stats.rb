# release_stats.rb
# parse Radiance releases from NREL's GitHub Repo
# 2018.10.15 R. Guglielmetti
# 2018.10.19 works directly with stdout, no temp files. - RPG
# https://api.github.com/repos/NREL/Radiance/releases
# USAGE: ruby release_stats.rb

require 'json'
require 'open3'

tempdata = "z_release_tempdata"

stdout,stderr,status = Open3.capture3("wget -O - https://api.github.com/repos/NREL/Radiance/releases")

STDERR.puts stderr
if status.success?

    releases = JSON.parse(stdout)
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

    puts "Done."

else

  STDERR.puts "Error downloading data."

end

