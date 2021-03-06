require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')
require_relative( '../models/adoption.rb' )
require_relative('../models/owner.rb')
require_relative('../models/capybara.rb')


get '/adoptions' do
  @adoptions = Adoption.all()
  erb (:"adoptions/index")
end

get '/adoptions/new' do
  @owners = Owner.all
  @capybaras = Capybara.all
  erb(:"adoptions/new")
end

post '/adoptions' do
  adoption = Adoption.new(params)
  adoption.save
  capybara = Capybara.find(adoption.capybara_id)
  capybara.get_adopted
  capybara.update
  redirect to("/adoptions")
end

post '/adoptions/:id/delete' do
  Adoption.delete(params[:id])
  redirect to("/adoptions")
end
