require './boot'

url = 'http://www.dmoz.org/Business/'
stage = MainHelper.get_stage(url)
root_page = RootPage.new(stage)

root_page.industries.each do |industry, industry_url|
  CrawlPage.perform_async(industry_url, industry)
end


