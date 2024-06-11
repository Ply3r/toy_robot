require 'sinatra'
require_relative '../toy_robot'

robot = ToyRobot.new

before do
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization, X-Requested-With'
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,POST,PUT,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Origin'] = '*'
  response.headers['Access-Control-Allow-Methods'] = 'HEAD,GET,POST,PUT,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization, X-Requested-With, X-HTTP-Method-Override, X-Forwarded-Proto, X-Request-Id'
  200
end

post '/exec_command' do
  robot.exec_command(params[:command]).to_json
end
