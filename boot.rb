require 'mechanize'
require 'singleton'
require 'byebug' #TODO move to development/test mode

Dir[File.dirname(__FILE__) + '/lib/helpers/*rb'].each { |file| require file }
Dir[File.dirname(__FILE__) + '/lib/*rb'].each { |file| require file }


