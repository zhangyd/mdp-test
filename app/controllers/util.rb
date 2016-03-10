#!/usr/bin/ruby
require "rubygems"
require "nokogiri"
require "Rugged"
require "digest/murmurhash"

module Util
	#input: 
	#output: /private/username/repo_name
	def get_user_path(username)
		#add param checking
		user_hash = Digest::MurmurHash1.hexdigest(username)
		#user_path = "#{RAILS_ROOT}/private/#{user_hash}"
		user_path = "#{Dir.pwd}/private/#{user_hash}"
		return user_path
	end

	# Design choice: hash every user + repo name to a hex string
	# to be used as local_path
	# input: 
	# output
	def get_repo_path(user_path, repo_name)
		repo_hash = Digest::MurmurHash1.hexdigest(repo_name)
		
		#repo_path = "#{RAILS_ROOT}/private/#{user_path}/#{repo_hash}"

		repo_path = "#{user_path}/#{repo_hash}"
		return repo_path
	end
end

#
# need a series of user input check
#
class Project
	#include Util
	def initialize(_name, _user, _url_addr)
		@name = _name
		@user = _user
		@url_addr = _url_addr
		@user_path = get_user_path(@user)
		@repo_path = get_repo_path(@name, @user_path)
		@reports = Array.new()
		# set up foder for storing report
		@report_path = @user_path + '/report'

		puts "report path#{@report_path}"
		#system "mkdir #{@report_path}"
	end

	
	def clone_from_remote
		@repo = Rugged::Repository.clone_at(@url_addr, @repo_path)
	end

	def scan
		t = Time.new
		report_name = "#{@repo_path}/#{t.strftime('%Y%m%d_%H%M%S')}.xml"
		
		cmd = "dependency-check --app #{@name} --format XML --out . --scan #{@repo_path}"
		system cmd
		#check successful
		# if File.directory?(report_name)
		# 	@reports.push(report_name)
		# end
	end

	def import_report
		#assume import the last generated report

		#need to add some check in future
		#empty check...

		xml = Nokogiri::XML(open(@reports.last))
		# => the xml obejct will now store the passed xml file
		# can we store this xml object???


		# dependency = xml.search('dependency').map do |dependency|
		# 	%w[
		# 		fileName filePath md5 sha1 description evidenceCollected identifiers vulnerabilities 
		# 	].each_with_object({}) do |n, o|
		# 	o[n] = dependency.at(n)
		# 	end
		# has_vulnerability = dependency.keep_if { |dep| !dep["vulnerabilities"].nil? }
		# puts dependency.size
		# ap has_vulnerability
	end

	def get_user_path(username)
		#add param checking
		user_hash = Digest::MurmurHash1.hexdigest(username)
		#user_path = "#{RAILS_ROOT}/private/#{user_hash}"
		user_path = "#{Dir.pwd}/private/#{user_hash}"

		puts "userpath#{user_path}" #debug
		return user_path
	end

	# Design choice: hash every user + repo name to a hex string
	# to be used as local_path
	# input: 
	# output
	def get_repo_path(repo_name,user_path)
		repo_hash = Digest::MurmurHash1.hexdigest(repo_name)
		
		#repo_path = "#{RAILS_ROOT}/private/#{user_path}/#{repo_hash}"

		repo_path = "#{user_path}/#{repo_hash}"

		puts "repo_path#{repo_path}" #debug
		return repo_path
	end
end