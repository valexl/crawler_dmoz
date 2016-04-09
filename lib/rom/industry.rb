class Industry 
  include Singleton
  attr_reader :main_repository

  def initialize
    @main_repository = MainRepo.new($rom_container)
  end

  def self.find(id)
    self.instance.main_repository.find_industry(id)
  end

  def self.find_by_url(url)
    self.instance.main_repository.find_industry_by_url(url)
  end

  def self.find_by_name(name)
    self.instance.main_repository.industries.where(name: name).as(IndustryItem).one
  end

  def self.all
    self.instance.main_repository.industries.as(IndustryItem).to_a
  end

  def self.where(attributes)
    self.instance.main_repository.industries.where(attributes).as(IndustryItem).to_a
  end

  def self.count
    self.instance.main_repository.count_industries
  end

  def self.domains(industry_title)
    industry = find_by_name(industry_title)
    Domain.where(id: self.instance.main_repository.domains_industries.where(industry_id: industry.id).as(DomainIndustryItem).to_a.map(&:domain_id))
  end

end

