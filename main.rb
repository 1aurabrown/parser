
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'


class ParseApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    puts "Welcome"
  end




  post '/' do
    params.delete("middleInitial")
    params[:dateOfBirth] =params[:dateOfBirth].gsub('-', '/')
    puts params[:dateOfBirth]

    

  end

end