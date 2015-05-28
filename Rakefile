#!/opt/chefdk/embedded/bin/rake

task default: 'foodcritic'

critiques = [
  "dcb_test",
  "dcb_test"
]

pipeline = [
  "dcb_test",
  "dcb_test"
]

desc "Runs foodcritic linter on cookbooks"
task :foodcritic do
  success = true
  critiques.each do |cookbook|
    system "foodcritic -f any cookbooks/#{cookbook}" || success = false
  end
  success
end

# comment
desc "Runs knife cookbook test on cookbooks"
task :knifetest do
  pipeline.each do |cookbook|
    system "bundle exec knife cookbook test #{cookbook} -c test/chef/knife.rb -o cookbooks"
  end
end

# comment
desc "Deploy cookbooks to Chef server"
task :deploy do
  pipeline.each do |cookbook|
    system "bundle exec knife cookbook upload #{cookbook} -c test/chef/knife.rb -o cookbooks"
  end
end
