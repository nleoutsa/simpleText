#
# use Twilio, data_mapper, and sqlite3 to send messages to any sms
# enabled phone number. nleoutsa
#

require 'rubygems'
require 'sinatra'
require 'data_mapper'
# require 'do_postgres'
require 'twilio-ruby'
# require 'pg'


# define TextMessage class per data_mapper documentation
class TextMessage

  include DataMapper::Resource

  property :id, Serial
  property :phone, String, :required => true
  property :content, Text, :required => true
  property :created_at, DateTime

end

# setup data_mapper with postgres
DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/texts.db")

# automatically update on new instance..
DataMapper.finalize.auto_upgrade!

# Twilio account info:
account_sid = ENV['TWILIO_ACCOUNT_SID']
auth_token = ENV['TWILIO_AUTH_TOKEN']
client = Twilio::REST::Client.new account_sid, auth_token

# my Twilio number, messages will be sent from this number.
from = "+16178588989"


# Sinatra 'get' route for '/' aka home page... shows index.erb
# and orders all instances of class TextMessage (desc = descending,
# asc = ascending)
get '/' do
  @texts = TextMessage.all :order => :id.asc
  erb :index

end

# create new instance of class TextMessage

post '/' do
  n = TextMessage.new
  n.phone = params[:phone]
  n.content = params[:content]
  n.created_at = Time.now
  n.save


#uncomment to actually send messages.. comment for testing js
#=begin
  client.account.messages.create(
      :from => from,
      :to => n.phone,
      :body => n.content
  )
#=end

# stay on home page...
  redirect '/'
end

