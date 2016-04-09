class DomainPage

  def initialize(stage)
    @stage = stage
  end

  def title
    @title ||= begin
                @stage.search("title").text.to_s.strip 
              rescue NoMethodError => e
                ''
              end
  end

  def meta_description
    @meta_description ||= begin
                          @stage.search("meta[name='description']").attr('content').to_s.strip  
                        rescue NoMethodError => e
                          ''
                        end
  end

end
