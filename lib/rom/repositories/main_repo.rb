class MainRepo < ROM::Repository
  relations :industries, :domains, :domains_industries

  #################################
  ######## Industries #############
  #################################
  def find_industry(id)
    industries.where(id: id).as(IndustryItem).one
  end

  def find_industry_by_url(url)
    industries.where(url: url).as(IndustryItem).one
  end

  def count_industries
    industries.count
  end

  #################################
  ########### Domains #############
  #################################

  def find_domain(id)
    domains.where(id: id).as(DomainItem).one
  end

  def find_domain_by_url(url)
    domains.where(url: url).as(DomainItem).one
  end

  def count_domains
    domains.count
  end

  def find_domains_by_industry(industry_name)
    industry = industries.where(name: industry_name).as(IndustryItem).one
    domain_industry_items = domains_industries.where(industry_id: industry.id).as(DomainIndustryItem).to_a
    domains.where(id: domain_industry_items.map(&:domain_id))
  end
end
