require "#{Dir.pwd}/boot"

Dir.glob('lib/tasks/*.rake').each { |r| load r}

