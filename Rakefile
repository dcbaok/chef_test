#!/opt/chefdk/embedded/bin/rake

# Whitelist of cookbooks to run tests against
critiques = [
  "dcb_test",
  "dcb_test2",
  "dcb_test3"
]

# Whitelist of cookbooks to deploy to Chef server
pipeline = [
  "dcb_test",
  "dcb_test2",
  "dcb_test3"
]

## Parse git log 

# Get the commit Travis is working on, or the most recent commit
travis_commit = ENV['TRAVIS_COMMIT']
unless travis_commit
  travis_commit = `git log --pretty=format:%H -1`
end
puts "Operating on commit '#{travis_commit}'"

# Parse the commit header
git_log = `git show #{travis_commit} --name-status`.split(/\n/)
commit = git_log.shift.split(/^commit /)[1]  # get commit hash (redundant but need shift anyway)
if git_log[0] =~ /^Merge: /   # is it a merge? 
  merge = git_log.shift.split(/^Merge: /)[1].split  # merge gets an array of (2) merge commit #'s
else
  merge = ""	# not a merge
end
author = git_log.shift.split(/^Author: /)[1]
date = git_log.shift.split(/^Date:\s+/)[1]

# Get commit message
message = []
if merge == ""
  until git_log[0] =~ /^\w/
    message.push(git_log.shift)
  end
else
  message = git_log
end

# Parse the file list
if git_log != []
  cookbooks = {}
  databags = {}
  environments = {}

  git_log.each do |item|
  if item =~ /^[AMD]\s+cookbooks\/([^\/]+)\//
    cookbooks[$1] = ""
  elsif item =~ /^[AMD]\s+databags\/(.*)$/
    databags[$1] = ""
  elsif item =~ /^[AMD]\s+environments\/(.*)$/
    environments[$1] = ""
  end
end


## Test

desc "Run tests on cookbooks changed in the current commit"
task :test_cookbooks do
  # TODO: check if cookbook directory is present, maybe cb was deleted?
  puts "Running cookbook tests:"
  if cookbooks == {}
    puts "   no cookbook deltas, skipping"
  end
  cookbooks.keys.each do |cb|
    if critiques.include?(cb)
      puts "   running cookbook tests on #{cb}"
      sh "foodcritic -f any --tags ~FC015 cookbooks/#{cb}"
      sh "bundle exec knife cookbook test #{cb} -c test/chef/knife.rb -o cookbooks"
    else
      puts "   #{cb} not whitelisted for testing, skipping"
    end
  end
end

task :test_databags do
desc "Run tests on databags changed in the current commit"
  puts "Running databag tests:"
  if databags == {}
    puts "   no databag deltas, skipping"
  end
  # run databag test
end

desc "Run tests on environments changed in the current commit"
task :test_environments do
  puts "Running environments tests:"
  if environments == {}
    puts "   no environments deltas, skipping"
  end
  # run environment test
end


desc "Run tests on changed cookbooks, databags, and environments"
task :test_chef_repo_changes
  Rake::Task['test_cookbooks'].execute
  Rake::Task['test_databags'].execute
  Rake::Task['test_environments'].execute
end


## Deploy

desc "Deploy cookbooks changed in the current commit to the Chef server"
task :deploy_cookbooks do
  # TODO: check if cookbook directory is present, maybe cb was deleted?
  # TODO: check if cookbook version has been updated (and matches changelog?).
  # TODO: check if cookbook changelog has been updated (and matches version?).
  cookbooks.keys.each do |cb|
    if pipeline.include?(cb)
      puts "Deploying #{cb} cookbook to Chef server."
      system "bundle exec knife cookbook upload #{cookbook} -c test/chef/knife.rb -o cookbooks"
    end
  end
end

desc "Deploy databags changed in the current commit to the Chef server"
task :deploy_databags do
  # run databag deploy
end

desc "Deploy environments changed in the current commit to the Chef server"
task :deploy_environments do
  # run environment deploy
end


desc "Deploy changed cookbooks, databags, and environments"
task :deploy_chef_repo_changes do
  Rake::Task['deploy_cookbooks'].execute
  Rake::Task['deploy_databags'].execute
  Rake::Task['deploy_environments'].execute
end


## Legacy

desc "Run foodcritic linter on all cookbooks"
task :foodcritic do
  critiques.each do |cookbook|
    sh "foodcritic -f any cookbooks/#{cookbook}" 
  end
end
desc "Run knife cookbook test on all cookbooks"
task :knifetest do
  pipeline.each do |cookbook|
    system "bundle exec knife cookbook test #{cookbook} -c test/chef/knife.rb -o cookbooks"
  end
end
desc "Deploy cookbooks to Chef server"
task :deploy do
  pipeline.each do |cookbook|
    system "bundle exec knife cookbook upload #{cookbook} -c test/chef/knife.rb -o cookbooks"
  end
end
