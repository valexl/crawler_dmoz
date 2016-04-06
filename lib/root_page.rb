class RootPage
  def initialize(stage)
    @stage = stage
    @url   = @stage.uri.to_s
  end

  def industries
    return @industries if @industries
    @stage.search(".dir-1 a").inject({}) do |res, a|
      res[a.text] = "http://www.dmoz.org#{a.attr('href')}"
      res
    end
  end

end
