class Domain 
  include Singleton

  attr_reader :main_repo

  def initialize
    @main_repo = DomainRepo.new($rom_container)
  end

  def self.find(id)
    self.instance.main_repo.find(id)
  end

  def self.find_by_url(url)
    self.instance.main_repo.find_by_url(url)
  end

  def self.all
    self.instance.main_repo.domains.as(IndustryItem).to_a rescue []
  end

  def self.where(attributes)
    self.instance.main_repo.domains.where(attributes).as(DomainItem).to_a
  end

  def self.count
    self.instance.main_repo.count
  end

end

