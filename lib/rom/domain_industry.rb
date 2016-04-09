class DomainIndustry
  include Singleton

  attr_reader :main_repo

  def initialize
    @main_repo = MainRepo.new($rom_container)
  end

  def self.all
    self.instance.main_repo.domains_industries.as(DomainIndustryItem).to_a
  end

  def self.where(attributes)
    self.instance.main_repo.domains_industries.where(attributes).as(DomainIndustryItem).to_a
  end

  def self.count
    self.instance.main_repo.domains_industries.count
  end

end

