#!/opt/chefdk/embedded/bin/rake

desc "Runs foodcritic linter"
task :foodcritic do
  if Gem::Version.new("2.1.0") <= Gem::Version.new(RUBY_VERSION.dup)
    sandbox = File.join(File.dirname(__FILE__), %w{tmp foodcritic cookbook})
    prepare_foodcritic_sandbox(sandbox)

    sh "foodcritic --epic-fail any #{File.dirname(sandbox)}"
  else
    puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 2.1.0."
  end
end

task :default => 'foodcritic'

private

def prepare_foodcritic_sandbox(sandbox)
  files = %w{*.md *.rb attributes definitions files libraries providers recipes resources templates}

  rm_rf sandbox
  mkdir_p sandbox
  Dir.chdir("cookbooks")
  cp_r Dir.glob("{#{files.join(',')}}"), ../sandbox
  puts "\n\n"
end
