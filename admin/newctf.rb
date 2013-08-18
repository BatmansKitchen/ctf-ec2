#!/usr/bin/ruby 
# Creates stuff for new CTF

require 'json'

# Public: Prints usage message.
#
# Returns nothing.
def print_usage
  puts
  puts "Usage: ./newctf.rb config_file.json"
  puts "This script takes a json config files and creates a directory named ctf_name in /var/ctf/competitions/ with sub-directories for each problem. Within each problem, a subdirectory for every user on the system is also created. Each user's directory is owned by them read and execute by all others"
end

# Public: Produces array of human users on the system. Takes no arguments.
#
# Returns array of the system's users.
def get_users
  users = []
  Dir.foreach(File.join("/", "home")) do |directory|
    users << directory unless directory == "." or directory == ".."
  end
  valid_users(users)
end

# Public: Filters array of users to make sure each is legitimate.
#
# users - An array of usernames found from another source. 
#
# Returns an array of validated users or raises a permissions or file exception.
def valid_users(users)
  system_users = []
  File.open(File.join("/", "etc", "passwd"), 'r') do |file_handle|
    file_handle.each_line do |line|
      system_users << line.split(':')[0]
    end
  end
  users.keep_if { |user| system_users.include? user }
  users
end

# Public: Opens and parses a JSON file
#
# file_name - the name of a JSON file to be parsed in the current directory
#
# Returns a hash of arrays containing the parsed JSON from the specified file
def parse_config_file(file_name)
  config_file = File.read(file_name)
  JSON.parse(config_file)
end

# Public: Sets up the specified directory structure for a new CTF. Namely, 
# in /var/ctf/competitions a folder of the CTF name is created with a
# subdirectory for each individual problem, and within each problem directory
# a folder is created for each user in addition to a share. Each user directory
# is owned by them, and r-x for everyone else. Shares are 777.
#
# ctf_name - A string containing the name of the CTF. Must not be empty.
# problems - An array containing a string for each problem in the CTF. Strings 
#            should not be empty nor violate Posix naming conventions
#
# Returns nothing or raises an error creating or chowing directories.
def setup_ctf_dir(ctf_name, problems)
  ctf_dir = File.join("/", "var", "ctf", "competitions", ctf_name)
  Dir.mkdir(ctf_dir, 0755)
  users = get_users
  Dir.chdir(ctf_dir)
  problems.each do |problem|
    Dir.mkdir(problem, 0755)
    Dir.chdir(problem) do |path|
      users.each do |user|
        Dir.mkdir(user, 0755) 
        system("chown #{user} #{user}")
      end
    end
  end
end

if ARGV.count == 1 and File.exists?(ARGV[0])
  config = parse_config_file(ARGV[0])
  setup_ctf_dir(config['name'], config['problems'])
else
  print_usage
end
