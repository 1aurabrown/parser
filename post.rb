# post_message.rb

require "net/http"
require "pry"




@@uri = URI("http://0.0.0.0:9292")



def line_to_hash(line, delimiter, keys)
  values = line.chomp.split(delimiter)
  values_hash = Hash[keys.zip(values)]
end


def parse_file(input_file, delimiter, keys)
  file = File.open(input_file)
  file.each_line do |line|
    values_hash = line_to_hash(line, delimiter, keys)
    response = Net::HTTP.post_form(@@uri, values_hash)
    binding.pry
  end
end


comma_keys = ["lastName", "firstName", "gender", "favoriteColor", "dateOfBirth"]
space_keys = ["lastName", "firstName", "middleInitial", "gender", "dateOfBirth", "favoriteColor"]
pipe_keys = ["lastName", "firstName", "middleInitial", "gender", "favoriteColor", "dateOfBirth"]


parse_file('comma.txt', ', ', comma_keys)
#parse_file('space.txt', ' ', space_keys)
#parse_file('pipe.txt', ' | ', pipe_keys)











