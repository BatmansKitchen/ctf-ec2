#!/usr/bin/ruby 
# Creates stuff for new CTF
# First argument is the JSON config file

require 'rubygems'
require 'json'

# Returns valid human users of the system
def get_users
    users = []
    Dir.foreach(File.join("/", "home")) do |directory|
        users << directory unless directory == "." or directory == ".."
    end
    users = valid_users(users)
    users
end

# Filters passed array of users by making sure they exist in /etc/passwd
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

# Takes JSON file name and returns parsed object
def parse_config_file(file_name)
    config_file = File.read(file_name)
    JSON.parse(config_file)
end

# Takes ctf_name and array of problem names. Creates directory named 
# ctf_name in /var/ctf/competitions/ and subdirectories for each problem.
# Within each problem, a subdirectory for every user on the system.
# Each user's directory is owned by them read and execute by all others
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

config = parse_config_file(ARGV[0])
setup_ctf_dir(config['name'], config['problems'])
