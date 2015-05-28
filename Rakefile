#!/opt/chefdk/embedded/bin/rake

task default: 'foodcritic'

critiques = [
  "dcb_test",
  "dcb_test2",
  "dcb_test3"
]

pipeline = [
  "dcb_test",
  "dcb_test2",
  "dcb_test3"
]

desc "Runs foodcritic linter on cookbooks"
task :foodcritic do
  critiques.each do |cookbook|
    sh "foodcritic -f any cookbooks/#{cookbook}" 
  end
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
