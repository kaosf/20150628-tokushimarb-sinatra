require 'sinatra'

run Sinatra::Application

public_dir = File.join(File.dirname(__FILE__), 'public')

get '/' do
  'Hello World'
end

get '/entries' do
  Dir.glob('./public/images/**').
    map { |i| File.basename i }.
    map { |i| "<a href=\"/images/#{i}\">#{i}</a>" }.
    join("<br>")
end

post '/entry' do
  File.open("public/images/#{params[:filename]}", "wb") do |f|
    f.write(params[:file][:tempfile].read)
  end
  200
end
