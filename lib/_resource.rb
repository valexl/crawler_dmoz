class Resource
  LIST = {}
  
  def self.save_new_resource(url, industry)
    Resource::LIST[url] = [] unless Resource::LIST[url]
    Resource::LIST[url].push(industry)
  end
  
end
