require 'spec_helper'

RSpec.describe Industry do
  let(:url) { "#{"file:///#{Dir.pwd}/spec/fixtures/industries/#{@file_name}.html"}"}
  let(:industry_name) { @industry_name }
  let(:industry) { described_class.new(MainHelper.get_stage(url), industry_name) }

  before(:each) do
    @file_name = 'business_ accounting'
    @industry_name = 'Accounting'
  
  end

  context '#nested_industries' do
    it 'returns expected list of industries for http://www.dmoz.org/Business/Accounting/' do
      expected_industries = {
        "Associations" => "http://www.dmoz.org/Business/Accounting/Associations/",
        "Business-to-Business" => "http://www.dmoz.org/Business/Accounting/Business-to-Business/",
        "By Region" => "http://www.dmoz.org/Business/Accounting/By_Region/",
        "CPE For CPAs" => "http://www.dmoz.org/Business/Accounting/CPE_For_CPAs/",
        "Dictionaries" => "http://www.dmoz.org/Reference/Dictionaries/By_Subject/Business/Accounting/",
        "Education and Training" => "http://www.dmoz.org/Business/Accounting/Education_and_Training/",
        "Employment" => "http://www.dmoz.org/Business/Accounting/Employment/",
        "Expert Witnesses" => "http://www.dmoz.org/Society/Law/Services/Expert_Witnesses/Financial/Accounting/",
        "Firms" => "http://www.dmoz.org/Business/Accounting/Firms/",
        "Household Employment" => "http://www.dmoz.org/Business/Accounting/Household_Employment/",
        "News and Media" => "http://www.dmoz.org/Business/Accounting/News_and_Media/",
        "Outsourcing" => "http://www.dmoz.org/Business/Financial_Services/Outsourcing/",
        "Resources" => "http://www.dmoz.org/Business/Accounting/Resources/",
        "Small Business" => "http://www.dmoz.org/Business/Small_Business/Finance/Accounting/",
        "Software" => "http://www.dmoz.org/Computers/Software/Accounting/",
        "Tax Negotiation and Representation" => "http://www.dmoz.org/Business/Accounting/Tax_Negotiation_and_Representation/",
      }

      expect(industry.nested_industries).to eq(expected_industries)
    end
  end

  context '#save_resources!' do
    it 'returns expected resources' do
      expected_resources = {"http://www.irs.gov/"=>["Accounting"], "http://www.sec.gov/edgar.shtml"=>["Accounting"], "http://www.fasb.org/"=>["Accounting"], "http://www.gasb.org/"=>["Accounting"], "http://www.pcaobus.org/"=>["Accounting"], "http://www.smartpros.com/"=>["Accounting"], "http://www.gao.gov/"=>["Accounting"]}
      Resource::LIST = {}

      industry.save_resources!

      expect(Resource::LIST).to eq(expected_resources)
    end
  end
end
