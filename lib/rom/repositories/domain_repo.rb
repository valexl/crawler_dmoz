class DomainRepo < ROM::Repository
  relations :domains

  def find(id)
    domains.where(id: id).as(DomainItem).one
  end

  def find_by_url(url)
    domains.where(url: url).as(DomainItem).one
  end

  def count
    domains.to_a.count
  end
end
