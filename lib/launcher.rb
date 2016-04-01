first_stage = MainHelper.get_stage('http://www.dmoz.org/Business/')
first_industry = 'Business'

business_industry = Industry.new(first_stage, first_industry)

business_industry.save_all_resources!

