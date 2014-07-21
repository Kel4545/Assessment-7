require 'sinatra/base'
require 'gschool_database_connection'

require './lib/country_list'
require './lib/users_table'

class Application < Sinatra::Application

  def initialize
    super
    @users_table = UsersTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))
  end

#Done after time was up

  get '/' do
   other_users = @users_table.find
    erb :index, :locals{:other_users :other_users}
  end


  post '/homepage' do
   @users_table.create(params[:username], params[:message])
    end
    redirect "/"


  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: {continents: all_continents}
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: {countries: list_of_countries, continent: params[:continent_name]}
  end



# WHY DO I KEEP MAKING THINGS FAR MOR COMPLICATED THAN THEY ACTUALLY ARE?
# Was trying to do the whole thing with sessions

