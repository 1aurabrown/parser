
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/contrib'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pry'





DataMapper::Logger.new($stdout, :debug)

ENV['DATABASE_URL'] ||= 'postgres://Laura:@localhost/dataparser'

DataMapper.setup(:default, ENV['DATABASE_URL'])

class ParseApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    @all = Parse.all
    erb :home
  end

  get '/output1' do
    @all= Parse.all
    erb :output1
  end

  get '/output2' do
    @all_by_dob = Parse.all(:order => [ :dateOfBirth.asc ])
    erb :output2
  end

  get '/output3' do
    @all = Parse.all
    erb :output3
  end


  post '/' do
    params.delete("middleInitial")
    dob =params["dateOfBirth"].gsub('-', '/')
    params["dateOfBirth"] = DateTime.strptime(dob, "%d/%m/%Y")
    params["gender"] = params["gender"][0].upcase

    table_row = Parse.new(params)
        binding.pry
    table_row.save

  end
end


class Parse
  include DataMapper::Resource

  property :id,             Serial        # Auto-increment integer id
  property :lastName,       String        # A short string of text
  property :firstName,      String        # A short string of text
  property :dateOfBirth,    DateTime      # A short string of text
  property :favoriteColor,  String        # A short string of text
  property :gender,         String        # A short string of text
  property :created_at,     DateTime      # Auto assigns data/time
end

DataMapper.finalize
DataMapper.auto_upgrade!