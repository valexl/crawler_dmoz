class MainRepo < ROM::Repository
  relations :industries, :domains


  def find_industry(id)
    industries.where(id: id).as(IndustryItem).one
  end

  def find_industry_by_url(url)
    domains.where(url: url).as(IndustryItem).one
  end

  def count_industries
    industries.to_a.count
  end

  def find_domain(id)
    domains.where(id: id).as(DomainItem).one
  end

  def find_domain_by_url(url)
    domains.where(url: url).as(DomainItem).one
  end

  def count_domains
    domains.to_a.count
  end
end
