require 'mechanize'
require 'singleton'

require 'byebug'

require 'rom'
require 'rom-sql'
require 'rom-repository'
require 'virtus'

require 'dotenv'

require 'sidekiq'


Dotenv.load

require "#{Dir.pwd}/db_setup"


Dir[Dir.pwd + '/lib/**/*rb'].each { |file| require file }


