class DMOZParser
  def initialize(path)
    @path = path
  end

  def load!
    proc = Proc.new {|attrs| save_domain!(attrs) }

    Xml::Parser.new(Nokogiri::XML::Reader(open(@path))) do |element|
      next if url.nil?
      attributes = {url: element.url}
      inside_element 'ExternalPage' do |element|
        for_element('topic') { attributes[:industry_url] = "http://www.dmoz.org/#{inner_xml.sub("Top/", '')}" }
        for_element('d:Title') { attributes[:title] = inner_xml}
        for_element('d:Description') { attributes[:description] = inner_xml}
      end
      proc.call(attributes)
    end
  end

  private

    def save_domain!(attributes)
      industry = Industry.all.find {|ind| attributes[:industry_url].include?(ind.url) }
      if industry.nil?
        if attributes[:industry_url].include?("Business") 
          puts "skip probably correct industry can - '#{attributes[:industry_url]}'"
        end
        return false
      end
      attributes[:industry] = industry
      if domain = Domain.find_by_url(attributes[:url])
        create_relationship_between_domain_and_industry!(domain.id, industry.id)
      else
        create_domain!(attributes)
      end

    end
      
    def create_domain!(attributes)
      create_domains  = $rom_container.commands[:domains][:create]
      domain = create_domains.call(attributes.slice(:url, :title, :description))[0]
      create_relationship_between_domain_and_industry!(domain[:id], attributes[:industry].id)
    end

    def create_relationship_between_domain_and_industry!(domain_id, industry_id)
      if DomainIndustry.where(domain_id: domain_id, industry_id: industry_id).count.zero?
        create_domains_industries  = $rom_container.commands[:domains_industries][:create]
        create_domains_industries.call(industry_id: industry_id, domain_id: domain_id)
      end
    end


end
