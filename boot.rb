require 'mechanize'
require 'singleton'

require 'rom'
require 'rom-sql'
require 'rom-repository'

require 'virtus'

require 'dotenv'

Dotenv.load
require "#{Dir.pwd}/db_setup"

Dir[Dir.pwd + '/lib/**/*rb'].each { |file| require file }


