require 'spec_helper'


RSpec.describe IndustryPage do
  let(:url) { "#{"file:///#{Dir.pwd}/spec/fixtures/industries/#{@file_name}.html"}"}
  let(:industry) { Industry.find_by_name industry_name }
  let(:industry_name) { @industry_name }
  let(:subject) { described_class.new(MainHelper.get_stage(url), industry) }
  let(:main_repository) { MainRepo.new($rom_container) }

  before(:each) do
    @file_name = 'Business_accounting'
    @industry_name = 'Accounting'

    clear_domains_table!
    clear_tmp_industries_table!
    allow(subject).to receive(:save_title_and_meta_description_for_domain!)
  end

  context '#sub_industries' do
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

      expect(subject.sub_industries).to eq(expected_industries)
    end
  end

  context '#save!' do
    it 'returns not false' do
      expect(subject.save!).to_not eq(false)
    end

    it 'saves to db' do
      expect do
        subject.save!
      end.to change(TmpIndustry, :count).by(1)
    end
  end

  context '#save_domains!' do
    let(:expected_domains) do
      {"http://www.irs.gov/"=>["Accounting"], "http://www.sec.gov/edgar.shtml"=>["Accounting"], "http://www.fasb.org/"=>["Accounting"], "http://www.gasb.org/"=>["Accounting"], "http://www.pcaobus.org/"=>["Accounting"], "http://www.smartpros.com/"=>["Accounting"], "http://www.gao.gov/"=>["Accounting"]}
    end

    it 'saves expected domains' do
      expect do
        subject.save_domains!
      end.to change(Domain, :count).by(expected_domains.keys.count)
    end

    it 'runs save_title_and_meta_description_for_domain! method for all domains' do
      expect(subject).to receive(:save_title_and_meta_description_for_domain!).exactly(expected_domains.keys.count).times
      subject.save_domains!
    end

    it 'creates association between industry' do
      expect do
        subject.save_domains!
      end.to change(DomainIndustry, :count).by(expected_domains.keys.count)
    end

    it 'creates association between industry for new industry' do
      subject.save_domains!

      expect do
        another_industry = Industry.find_by_name 'Business and Society'
        described_class.new(MainHelper.get_stage(url), another_industry).save_domains!
      end.to change(DomainIndustry, :count).by(expected_domains.keys.count)
    end

    it 'does not create new association between industry and domains if it is already exists' do
      subject.save_domains!
      expect do
        subject.save_domains!
      end.to change(DomainIndustry, :count).by(0)
    end

    it "won't save it agains" do
      subject.save_domains!
      expect do
        subject.save_domains!
      end.to change(Domain, :count).by(0)
    end
  end
end
