task :create_user => :environment do
  STDOUT.puts "Input email:"
  email = STDIN.gets.chomp
  STDOUT.puts "Input password:"
  password = STDIN.gets.chomp
  Admin::User.create!(email: email, password: password)
end