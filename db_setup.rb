DB_URI = ENV['DB_URI']

puts '##############################'
puts '##### Set up databaes ########'
puts '##############################'
puts DB_URI
puts '##############################'

$rom_container = ROM.container(:sql, DB_URI) do |rom|
  rom.gateways.values.each do |gateway|
    begin
      gateway.connection.create_table :industries do
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
        Text   :industries
      end
    rescue Exception => e
      puts '!!!!!!!!!!!!!!!!'      
      puts e
      puts '!!!!!!!!!!!!!!!!'      
    end

  end
  rom.use :macros

  rom.relation(:industries) do
    def find(id)
      where(id: id)
    end
  end

  rom.relation(:domains) do
    def find(id)
      where(id: id)
    end

  end

  rom.commands(:industries) do
    define(:create)
    define(:update)
    define(:delete)
  end

  rom.commands(:domains) do
    define(:create)
    define(:update)
    define(:delete)
  end
end
