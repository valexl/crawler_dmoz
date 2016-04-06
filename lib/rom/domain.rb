class Domain 
  include Singleton

  attr_reader :main_repo

  def initialize
    @main_repo = MainRepo.new($rom_container)
  end

  def self.find(id)
    self.instance.main_repo.find_domain(id)
  end

  def self.find_by_url(url)
    self.instance.main_repo.find_domain_by_url(url)
  end

  def self.all
    self.instance.main_repo.industries.as(DomainItem).to_a rescue []
  end

  def self.where(attributes)
    self.instance.main_repo.industries.where(attributes).as(DomainItem).to_a
  end

  def self.count
    self.instance.main_repo.count_domains
  end

end

