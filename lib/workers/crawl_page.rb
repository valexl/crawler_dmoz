class CrawlPage
  include Sidekiq::Worker
  
  def perform(url, name)
    stage = MainHelper.get_stage(url)
    industry_page = IndustryPage.new(stage, Industry.find_by_name(name))
    industry_page.save_all_domains!
  end
end
