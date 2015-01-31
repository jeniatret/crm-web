#require_relative 'contact'
#require_relative 'rolodex'
require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource

  property :id, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :note, String
 
  #attr_accessor :id, :first_name, :last_name, :email, :note

 #  def initialize(first_name, last_name, email, note)
 #    @id = id
 #    @first_name = first_name
 #    @last_name = last_name
 #    @email = email
 #    @note = note
 #  end
	# def to_s
	# 	"#{id}: #{first_name} #{last_name}, #{email}, #{note}"
	# end
end

DataMapper.finalize
DataMapper.auto_upgrade!

#end of Datamapper setup



#@@rolodex = Rolodex.new

#begin sinatra routes 
get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get '/contacts' do
	@contacts = Contact.all
	erb :contacts 
end

get '/contacts/new' do
	erb :new_contact
end

post '/contacts' do
 	contact = Contact.create(
 		:first_name => params[:first_name],
 		:last_name => params[:last_name],
 		:email => params[:email], 
 		:note => params[:note]
 		)
  	#@@rolodex.add_contact(new_contact)
  	redirect to('/contacts')
end

get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    @contact.save
    redirect to('/contacts')
  else
    raise Sinatra::NotFound
  end
end

get "/search/" do
	
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

