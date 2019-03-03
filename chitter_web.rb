require 'sinatra/base'
require './lib/peep'
require './lib/maker'


class ChitterWeb < Sinatra::Base

  enable :sessions

  get '/' do
    erb(:index)
  end

  get '/chitter/signup' do
    erb(:signup)
  end

  post '/chitter/signup' do

    @maker = Maker.create(name: params[:name], user_name: params[:user_name], email: params[:email], password: params[:password])
    session[:maker_id] = @maker.id

    redirect '/chitter/maker/homepage'

  end

  get '/chitter/login' do
    erb(:login)
  end

  post '/chitter/login' do
    @maker = Maker.find(email: params[:email], password: params[:password])
    session[:maker_id] = @maker.id

    redirect '/chitter/maker/homepage'

  end

  get '/chitter/maker/homepage' do
    @maker = Maker.read(id: session[:maker_id])
    erb(:homepage)
  end

  get '/chitter/peep/new' do
    erb(:new_peep)
  end

  post '/chitter/peep/new' do
    message = params[:message]
    Peep.create(message: message, posted_by: 1)
    redirect '/chitter/peep/all'
  end

  get '/chitter/peep/all' do
    @all_peeps = Peep.all
    erb(:all_peeps)
  end

  get '/chitter/peep/:id' do
    @peep = Peep.read(id: params[:id])
    erb(:peep_detail)
  end

  run! if app_file == $0
end
