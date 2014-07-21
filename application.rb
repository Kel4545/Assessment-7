require 'sinatra/base'
require 'gschool_database_connection'

require './lib/country_list'
require './lib/users_table'

class Application < Sinatra::Application

  def initialize
    super
    @users_table = UsersTable.new(GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"]))
  end

  get '/' do
    erb :index
  end

  get '/homepage' do
    if session[:id]
      erb :message_page, locals: {other_users: other_users}
    else
      erb :homepage
    end
  end

  post '/homepage' do
    @users_table.create(params[:username], params[:message])
    user = @users_table.find_by(params[:username], params[:message])
    if user
      session[:id] = user ["id"]
    end
    redirect '/homepage'
  end

  get '/continents' do
    all_continents = CountryList.new.continents
    erb :continents, locals: {continents: all_continents}
  end

  get '/continents/:continent_name' do
    list_of_countries = CountryList.new.countries_for_continent(params[:continent_name])
    erb :countries, locals: {countries: list_of_countries, continent: params[:continent_name]}
  end
end


