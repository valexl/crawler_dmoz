ENV['DB_URI'] = "sqlite://#{Dir.pwd}/db/test.sqlite3"

def clear_database!
  File.truncate("#{Dir.pwd}/db/test.sqlite3", 0)
end

def clear_domains_table!
  Domain.all.each do |domain|
    $rom_container.commands[:domains][:delete].find(domain.id)
  end
end
  
def clear_industries_table!
  Industry.all.each do |industry|
    $rom_container.commands[:industries][:delete].find(industry.id).call
  end
  
end
clear_database!

load('boot.rb') #FIXME won't be loaded if try to load this file not from root folder
