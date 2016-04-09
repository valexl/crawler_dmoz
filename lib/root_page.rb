class RootPage
  def initialize(stage)
    @stage = stage
    @url   = @stage.uri.to_s
  end

  def industries
    return @industries if @industries
    @industries = @stage.search(".dir-1 a").inject({}) do |res, a|
      res[a.text] = "http://www.dmoz.org#{a.attr('href')}"
      res
    end
    if Industry.count.zero?
      @industries.each do |name, url|
        create_industry = $rom_container.commands[:industries][:create]
        create_industry.call name: name, url: url
      end
    end
    @industries
  end

end
