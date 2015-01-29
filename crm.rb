require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

$rolodex= Rolodex.new
@@rolodex = Rolodex.new
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

#different routs 
get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	erb :contacts 
end 

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
 	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
  	$rolodex.add_contact(new_contact)
  	redirect to('/')
end