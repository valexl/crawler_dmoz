require 'rake'
load('boot.rb')
Dir.glob('lib/tasks/*.rake').each { |r| load r}

