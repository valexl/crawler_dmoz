class DomainItem 
  include Virtus.model

  attribute :id, Integer
  attribute :name, String
  attribute :url, String
  attribute :industries, String
  attribute :title, String
  attribute :meta_description, String
  
end
