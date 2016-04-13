DB_URI = ENV['DB_URI']

puts '##############################'
puts '##### Set up databaes ########'
puts '##############################'
puts DB_URI
puts '##############################'

$rom_container ||= ROM.container(:sql, DB_URI) do |rom|
  rom.gateways.values.each do |gateway|
    begin
      gateway.connection.create_table :industries do #it contains only http://www.dmoz.org/Business/ industries
        primary_key :id
        String :name
        String :url
      end
    rescue Sequel::DatabaseError => e
      puts '!!!!!!!!!!!!!!!!'      
      puts e
      puts '!!!!!!!!!!!!!!!!'      
    end

    begin
      gateway.connection.create_table :domains do
        primary_key :id
        String :name
        String :url
        String :title
        Text   :description
      end
    rescue Exception => e
      puts '!!!!!!!!!!!!!!!!'      
      puts e
      puts '!!!!!!!!!!!!!!!!'      
    end

    begin
      gateway.connection.create_table :domains_industries do
        primary_key :id
        Integer :domain_id
        Integer :industry_id
      end
    rescue Exception => e
      puts '!!!!!!!!!!!!!!!!'      
      puts e
      puts '!!!!!!!!!!!!!!!!'      
    end
  end

  rom.use :macros

  [:industries, :domains, :domains_industries].each do |relation_name|
    rom.relation(relation_name) do
      def find(id)
        where(id: id)
      end
    end

    rom.commands(relation_name) do
      define(:create)
      define(:update)
      define(:delete)
    end
  end


end
