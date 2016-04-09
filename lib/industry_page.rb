class IndustryPage
  def initialize(stage, industry)
    @stage = stage
    @url   = @stage.uri.to_s
    @name  = industry.name
    @current_position = -1 #current position for sub_industries
    @industry = industry
    # puts self.to_s
  end

  def to_s
    "#{@name} - #{@url}"
  end

  def save!
    return false if TmpIndustry.find_by_url(@url)
    return false unless @url.match /Business/
    create_industry = $rom_container.commands[:tmp_industries][:create]
    create_industry.call name: @name, url: @url
  end

  def sub_industries
    return @industries if @industries
    @stage.search(".dir-1 a").inject({}) do |res, a|
      res[a.text] = "http://www.dmoz.org#{a.attr('href')}"
      res
    end
  end

  def save_domains!
    @stage.search(".directory-url a.listinglink").each do |resource_link|
      resource_url = resource_link.attr('href')
      resource_name = resource_link.text
      domain = Domain.find_by_url(resource_url)
      if domain
        update_domain!(domain, resource_url, resource_name)
      else
        create_domain!(resource_url, resource_name)
      end
    end
  end

  def save_all_domains!
    return unless save!
    save_domains!
    while industry = next_sub_industry do
      industry.save_all_domains!
    end
  end

  def next_sub_industry
    @current_position += 1
    industry_title = sub_industries.keys[@current_position]
    industry_url   = sub_industries[industry_title]
    return nil unless industry_title
    next_sub_industry if TmpIndustry.find_by_url(industry_url)
    stage = MainHelper.get_stage(industry_url)
    IndustryPage.new(stage, @name)
  end

  private
    def create_domain!(url, name)
      create_domains  = $rom_container.commands[:domains][:create]
      domain = create_domains.call(url: url, name: name, industries: @name)[0]
      create_relationship_between_domain_and_industry!(domain[:id])
      save_title_and_meta_description_for_domain!(domain)
    end

    def save_title_and_meta_description_for_domain!(domain)
      begin
        page = DomainPage.new(MainHelper.get_stage(domain[:url]))
        update_domains = $rom_container.commands[:domains][:update]
        update_domains.find(domain[:id]).call title: page.title, meta_description: page.meta_description
      rescue Exception => e
        puts '###################################################'      
        puts '##### TRY TO SAVE TITLE AND META INFORMATION ######'      
        puts e
        puts '###################################################'      
      end
    end

    def update_domain!(domain, url, name)
      industries = domain.industries.to_s.split(",")
      industries.push(@name)
      update_domains = $rom_container.commands[:domains][:update]
      update_domains.find(domain.id).call url: url, name: name, industries: industries.uniq.join(",")
      create_relationship_between_domain_and_industry!(domain.id)
    end

    def create_relationship_between_domain_and_industry!(domain_id)
      if DomainIndustry.where(domain_id: domain_id, industry_id: @industry.id).count.zero?
        create_domains_industries  = $rom_container.commands[:domains_industries][:create]
        create_domains_industries.call(industry_id: @industry.id, domain_id: domain_id)
      end
    end
end
