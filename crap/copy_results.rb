#!/usr/bin/ruby
#
# Silly little utility to grab Asset Score results along with a few datapoints' input and log files
# 2016.05.23 RPG
#
# Usage: 
# - Put the script someplace callable;
# - Update the projects and number of datapoints you want;
# - Run from the asset score output dir where your project is, e.g.:
# ~/assetscore-results-data/asset_score_distributions_2016_05_20
#
# TODO
# - make simulations list an arg
# - make datapoints number an arg
#
# will probably use this 87 times in the next month and then never again tho. 

require 'FileUtils'

unless File.directory?("_copy_results")
	Dir.mkdir("_copy_results")
end

#["large_office_central_chiller_gas", "medium_office_packaged_rooftop_vav_with_electric_reheat_gas", "retail_packaged_rooftop_air_conditioner_gas"].each do |indir|
["large_office_central_chiller_gas"].each do |indir|

	puts "Saving run log(s), data, and input file(s) for simulation: \n'#{indir.upcase}'"
	dest = "_copy_results/#{indir}"
	data = Dir.glob("#{indir}/*.csv")
	unless File.directory?(dest)
		Dir.mkdir(dest)
	end

	datapoints = Dir.glob("#{indir}/data_points/*/")

	datapoints_select = 100

	if datapoints.size <= datapoints_select
		data_copy = datapoints
		puts "- Saving all (#{datapoints.size} of #{datapoints.size}) datapoints"

	else
		data_copy = datapoints.sample(datapoints_select)
		puts "- Saving #{datapoints_select} of #{datapoints.size} total datapoints"
	end

	data_copy.each do |dir|
		# puts "dir = #{dir}"
		uuid = dir.split("/")[-1]
		puts " - #{uuid}"
		FileUtils.cp(data, dest)
		unless File.directory?("_copy_results/#{indir}/#{uuid}")
			Dir.mkdir("_copy_results/#{indir}/#{uuid}")
		end
		copylist = "#{indir}/data_points/#{uuid}/run/run.log", "#{indir}/data_points/#{uuid}/run/in.idf"
		FileUtils.cp(copylist, "#{dest}/#{uuid}")
	end

end