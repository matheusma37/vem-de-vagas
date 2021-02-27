require 'rails_helper'

describe JobOpportunityHelper do
  describe '#human_attribute_enum' do
    it 'translates JobOpportunity enum attributes' do
      helper.human_attribute_enum(
        :job_opportunity,
        :professional_level,
        :junior
      ).should eql('Júnior')

      helper.human_attribute_enum(
        :job_opportunity,
        :professional_level,
        :analyst
      ).should eql('Pleno')

      helper.human_attribute_enum(
        :job_opportunity,
        :professional_level,
        :senior
      ).should eql('Sênior')

      helper.human_attribute_enum(
        :job_opportunity,
        :status,
        :enable
      ).should eql('Ativada')

      helper.human_attribute_enum(
        :job_opportunity,
        :status,
        :disable
      ).should eql('Desativada')
    end
  end
end
