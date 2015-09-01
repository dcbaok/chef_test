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


## Test

desc "Run tests on cookbooks"
task :test_cookbooks do
  # TODO: check if cookbook directory is present, maybe cb was deleted?
  puts "--| Running cookbook tests:"
  critiques.each do |cb|
    sh "foodcritic -f any --tags ~FC015 cookbooks/#{cb}"
    sh "bundle exec knife cookbook test #{cb} -c test/chef/knife.rb -o cookbooks"
  end
end

desc "Run tests on databags" 
task :test_databags do
  puts "--| Running databag tests:"
  # run databag tests
end

desc "Run tests on environments"
task :test_environments do
  puts "--| Running environments tests:"
  # run environment tests
end


desc "Run tests on cookbooks, databags, and environments"
task :test_chef_repo do
  Rake::Task['test_cookbooks'].execute
  Rake::Task['test_databags'].execute
  Rake::Task['test_environments'].execute
end


## Deploy

desc "Deploy cookbooks to the Chef server"
task :deploy_cookbooks do
  # TODO: check if cookbook directory is present, maybe cb was deleted?
  # TODO: check if cookbook version has been updated (and matches changelog?).
  # TODO: check if cookbook changelog has been updated (and matches version?).
  # TODO: if cookbook hasn't changed in git, but is newly added to the pipeline, it won't deploy
  #		- handle this by diffing the rakefile...
  cookbooks.keys.each do |cb|
    if pipeline.include?(cb)
      puts "--| Deploying #{cb} cookbook to Chef server."
      system "bundle exec knife cookbook upload #{cookbook} -c test/chef/knife.rb -o cookbooks"
    end
  end
end

desc "Deploy databags to the Chef server"
task :deploy_databags do
  # run databag deploy
end

desc "Deploy environments to the Chef server"
task :deploy_environments do
  # run environment deploy
end


desc "Deploy changed cookbooks, databags, and environments"
task :deploy_chef_repo do
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
