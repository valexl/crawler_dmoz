require 'spec_helper'

RSpec.describe DMOZParser do
  let(:subject) { described_class.new(path_to_file) }
  let(:path_to_file) { @path_to_file }

  before(:each) do
    @path_to_file = "#{Dir.pwd}/spec/fixtures/top_business_accounting.xml"
    @industry_name = "Accounting"
    clear_domains_table!
    clear_domains_industries_table!
    expect(Industry.count).to eq(48)
    expect(DomainIndustry.count).to eq(0)
    expect(Domain.count).to eq(0)
  end

  context '#load' do
    it 'creates 7 domains (only businesses)' do
      expect do
        subject.load!
      end.to change(Domain, :count).to (7)
    end

    it 'creates association between industry' do
      expect do
        subject.load!
      end.to change(DomainIndustry, :count).by(7)
      domain_industry = DomainIndustry.all.first
      expect(Industry.find(domain_industry.industry_id).name).to eq(@industry_name)
    end

    it 'does not create new association between industry and domains if it is already exists' do
      subject.load!
      expect do
        subject.load!
      end.to change(DomainIndustry, :count).by(0)
    end

    it "won't save it agains" do
      subject.load!
      expect do
        subject.load!
      end.to change(Domain, :count).by(0)
    end

    context 'detect industry by occurrence' do
      before(:each) do
        @path_to_file = "#{Dir.pwd}/spec/fixtures/top_business_accounting_associations.xml"
      end
      
      it 'creates 2 domains' do
        expect do
          subject.load!
        end.to change(Domain, :count).by(2)
      end
  
      it 'creates 2 association between industry and domains' do
        expect do
          subject.load!
        end.to change(DomainIndustry, :count).by(2)
        domain_industry = DomainIndustry.all.first
        expect(Industry.find(domain_industry.industry_id).name).to eq(@industry_name)
      end
    end

  end
  
end
