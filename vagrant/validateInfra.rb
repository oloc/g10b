require 'json'

fileContent = JSON.parse(File.read("infra.json"), symbolize_names: true)

fileContent.each do |node|
  puts node[:node]
  puts node[:iplastdigit]
  puts node[:host]
  puts node[:memory]
  puts node[:cpu]
  puts "***"
end