#!/opt/chefdk/embedded/bin/rake

task :default => 'foodcritic'

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("2.1.0") <= Gem::Version.new(RUBY_VERSION.dup)
    sh "foodcritic -f any cookbooks/dcb_test" 
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 2.1.0"
  end
end

desc "Runs knife cookbook test"
task :knife do
  sh "bundle exec knife cookbook test dcb_test -c test/chef/knife.rb -o cookbooks"
end

desc "Deploy to Chef server"
task :deploy do
  sh "bundle exec knife cookbook upload dcb_test -c .chef/knife.rb"
end
