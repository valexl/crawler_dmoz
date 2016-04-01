class Industry
  def initialize(stage, industry)
    @stage    = stage
    @industry = industry
    @current_position = -1 #current position for nested_industriess
    puts self.to_s
  end

  def to_s
    @industry  
  end

  def nested_industries
    return @industries if @industries
    @stage.search(".dir-1 a").inject({}) do |res, a|
      res[a.text] = "http://www.dmoz.org#{a.attr('href')}"
      res
    end
  end

  def save_resources!
    @stage.search(".directory-url a.listinglink").each do |resource_link|
      Resource.save_new_resource(resource_link.attr('href'), @industry)
    end
  end

  def save_all_resources!
    save_resources!
    while industry = next_industry do
      industry.save_all_resources!
    end
  end

  def next_industry
    @current_position += 1
    industry_title = nested_industries.keys[@current_position]
    return nil unless industry_title
    stage = MainHelper.get_stage(nested_industries[industry_title])
    Industry.new(stage, industry_title)
  end
end
