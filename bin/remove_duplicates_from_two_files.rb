#!/usr/bin/env ruby-local-exec

 # Author: Matti
 # Version: 0.1
 # Usage: ./remove_duplicates_from_two_files.rb path/to/first/file path/to/second/file

first_file_path = ARGV[0]
second_file_path = ARGV[1]

first_file = File.open(first_file_path)
second_file = File.open(second_file_path)

elements_from_first_file = []
first_file.each_line { |line| elements_from_first_file << line }
first_file.close

elements_from_second_file = []
second_file.each_line { |line| elements_from_second_file << line }
second_file.close

common_elements = (elements_from_first_file & elements_from_second_file)

if common_elements.empty?
  puts 'No common elements found. Nothing to do, yay!'
  exit
end

unique_elements_from_first_file = elements_from_first_file - common_elements
unique_elements_from_second_file = elements_from_second_file - common_elements

first_file = File.open(first_file_path, 'w')
second_file = File.open(second_file_path, 'w')

unique_elements_from_first_file.each { |elem| first_file.write(elem) }
first_file.close

unique_elements_from_second_file.each { |elem| second_file.write(elem) }
second_file.close

puts "Removed #{common_elements.size} common element(s):"
puts common_elements.map(&:chomp).join(', ')
exit

