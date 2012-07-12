#!/usr/bin/env ruby-local-exec

 # Author: Matti
 # Version: 0.1
 # Usage: ./show_duplicates_from_two_files.rb path/to/first/file path/to/second/file

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
else
  puts "#{common_elements.size} common element(s) found:"
  puts common_elements.map(&:chomp).join(', ')
end

exit

