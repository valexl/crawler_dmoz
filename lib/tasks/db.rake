namespace :data do

  namespace :load do
    desc 'Init Industries'
    task :industries do
      Industry.all.each do |industry|
        $rom_container.commands[:industries][:delete].find(industry.id).call
      end

      urls  = ["http://www.dmoz.org/Business/Accounting/", "http://www.dmoz.org/Business/Business_and_Society/", "http://www.dmoz.org/Business/Cooperatives/", "http://www.dmoz.org/Business/Customer_Service/", "http://www.dmoz.org/Business/E-Commerce/", "http://www.dmoz.org/Business/Education_and_Training/", "http://www.dmoz.org/Business/Employment/", "http://www.dmoz.org/Business/Human_Resources/", "http://www.dmoz.org/Business/Information_Services/", "http://www.dmoz.org/Business/International_Business_and_Trade/", "http://www.dmoz.org/Business/Investing/", "http://www.dmoz.org/Business/Major_Companies/", "http://www.dmoz.org/Business/Management/", "http://www.dmoz.org/Business/Marketing_and_Advertising/", "http://www.dmoz.org/Business/Opportunities/", "http://www.dmoz.org/Business/Small_Business/", "http://www.dmoz.org/Business/Aerospace_and_Defense/", "http://www.dmoz.org/Business/Agriculture_and_Forestry/", "http://www.dmoz.org/Business/Arts_and_Entertainment/", "http://www.dmoz.org/Business/Automotive/", "http://www.dmoz.org/Business/Biotechnology_and_Pharmaceuticals/", "http://www.dmoz.org/Business/Business_Services/", "http://www.dmoz.org/Business/Chemicals/", "http://www.dmoz.org/Business/Construction_and_Maintenance/", "http://www.dmoz.org/Business/Consumer_Goods_and_Services/", "http://www.dmoz.org/Business/Electronics_and_Electrical/", "http://www.dmoz.org/Business/Energy/", "http://www.dmoz.org/Business/Environment/", "http://www.dmoz.org/Business/Financial_Services/", "http://www.dmoz.org/Business/Food_and_Related_Products/", "http://www.dmoz.org/Business/Healthcare/", "http://www.dmoz.org/Business/Hospitality/", "http://www.dmoz.org/Business/Industrial_Goods_and_Services/", "http://www.dmoz.org/Business/Information_Technology/", "http://www.dmoz.org/Business/Materials/", "http://www.dmoz.org/Business/Mining_and_Drilling/", "http://www.dmoz.org/Business/Publishing_and_Printing/", "http://www.dmoz.org/Business/Real_Estate/", "http://www.dmoz.org/Business/Retail_Trade/", "http://www.dmoz.org/Business/Telecommunications/", "http://www.dmoz.org/Business/Textiles_and_Nonwovens/", "http://www.dmoz.org/Business/Transportation_and_Logistics/", "http://www.dmoz.org/Business/Wholesale_Trade/", "http://www.dmoz.org/Business/Associations/", "http://www.dmoz.org/Business/Directories/", "http://www.dmoz.org/Business/News_and_Media/", "http://www.dmoz.org/Business/Regional/", "http://www.dmoz.org/Business/Resources/"]
      names = ["Accounting", "Business and Society", "Cooperatives", "Customer Service", "E-Commerce", "Education and Training", "Employment", "Human Resources", "Information Services", "International Business and Trade", "Investing", "Major Companies", "Management", "Marketing and Advertising", "Opportunities", "Small Business", "Aerospace and Defense", "Agriculture and Forestry", "Arts and Entertainment", "Automotive", "Biotechnology and Pharmaceuticals", "Business Services", "Chemicals", "Construction and Maintenance", "Consumer Goods and Services", "Electronics and Electrical", "Energy", "Environment", "Financial Services", "Food and Related Products", "Healthcare", "Hospitality", "Industrial Goods and Services", "Information Technology", "Materials", "Mining and Drilling", "Publishing and Printing", "Real Estate", "Retail Trade", "Telecommunications", "Textiles and Nonwovens", "Transportation and Logistics", "Wholesale Trade", "Associations", "Directories", "News and Media", "Regional", "Resources"]
      names.each_with_index do |industry_name, index|
        $rom_container.commands[:industries][:create].call name: industry_name, url: urls[index]
      end
    end
  end
  

end

