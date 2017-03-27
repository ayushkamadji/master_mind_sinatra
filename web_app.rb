$LOAD_PATH.unshift File.expand_path('../lib/', __FILE__)

require 'sinatra'
require 'sinatra/reloader'
require 'master_mind'

configure do
  enable :sessions
  set :session_secret, "secret"
end

GAMES = {}

get '/' do
  session.each { |item| puts item }

  session_id = session['session_id']

  if GAMES[session_id] == nil
    redirect to('/newgame')
  end

  game = GAMES[session_id]

  erb :index, :locals => {board: game.board}
end

get '/newgame' do
  session_id = session['session_id']

  GAMES[session_id] = Game.new
  
  redirect to('/')
end

post '/' do
  session_id = session['session_id']
  game = GAMES[session_id]

  move = [params['move_0'].to_sym, 
          params['move_1'].to_sym,
          params['move_2'].to_sym,
          params['move_3'].to_sym]

  game.update(move)
  game.end_turn

  if game.over?
    redirect to('/gameover')
  end

  erb :index, :locals => {board: game.board}
end

get '/gameover' do
  session_id = session['session_id']
  game = GAMES[session_id]

  erb :game_over, :locals => {game: game}
end
