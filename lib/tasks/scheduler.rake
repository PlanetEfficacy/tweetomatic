desc "This task checks for new tweets and responds to them appropriately"
task :run_tweetomatic => :environment do
  puts "Running tweetomatic..."
  Runner.run
  puts "done."
end
