class IndustryRepo < ROM::Repository
  relations :industries

  def find(id)
    industries.where(id: id).as(IndustryItem).one
  end

  def find_by_url(url)
    industries.where(url: url).as(DomainItem).one
  end

  def count
    industries.to_a.count
  end

end
