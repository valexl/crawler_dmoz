ENV['DB_URI'] ='postgres://localhost/dmoz_test'

def clear_database!
  File.truncate("#{Dir.pwd}/db/test.sqlite3", 0)
  clear_domains_table!
  clear_domains_industries_table!
end

def clear_domains_table!
  Domain.all.each do |domain|
    $rom_container.commands[:domains][:delete].find(domain.id).call
  end
end

def clear_domains_industries_table!
  DomainIndustry.all.each do |domain_industry|
    $rom_container.commands[:domains_industries][:delete].find(domain_industry.id).call
  end
end
  
load('boot.rb') #FIXME won't be loaded if try to load this file not from root folder
load('Rakefile.rb') #FIXME won't be loaded if try to load this file not from root folder

clear_database!
Rake::Task['data:load:industries'].invoke


