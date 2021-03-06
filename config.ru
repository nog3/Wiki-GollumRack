require "rubygems"
require "bundler"

Bundler.require(:default)

require "omniauth"
require 'omniauth/strategies/google_oauth2'

require 'gollum/app'
require './views/layout'
require "./api.rb"

options = {
  :providers => Proc.new do
    provider :google_oauth2, ENV['GOLLUM_AUTH_GOOGLE_CLIENTID'], ENV['GOLLUM_AUTH_GOOGLE_SECRET']
  end,
  :dummy_auth => false,
  :protected_routes => [
    '/Members/*',
    '/revert/*',
    '/revert',
    '/create/*',
    '/create',
    '/edit/*',
    '/edit',
    '/rename/*',
    '/rename',
    '/delete/*',
    '/delete'
  ]
}

Precious::App.set(:omnigollum, options)

Precious::App.register Omnigollum::Sinatra

Precious::App.set(:gollum_path, ENV['GOLLUM_DATA_PATH'])

Precious::App.set(:wiki_options, {
  :live_preview => false,
  :css => true
})

Precious::App.settings.mustache[:templates] = './templates'

use Api
run Precious::App
