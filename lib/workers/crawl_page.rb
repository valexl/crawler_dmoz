class CrawlPage
  include Sidekiq::Worker
  
  def perform(url, title)
    stage = MainHelper.get_stage(url)
    industry_page = IndustryPage.new(stage, title)
    industry_page.save_all_domains!
  end
end
