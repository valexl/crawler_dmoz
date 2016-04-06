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

  def self.all
    self.instance.main_repository.industries.as(IndustryItem).to_a
  end

  def self.where(attributes)
    self.instance.main_repository.industries.where(attributes).as(IndustryItem).to_a
  end

  def self.count
    self.instance.main_repository.count_industries
  end

end

