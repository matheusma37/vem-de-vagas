require 'rails_helper'

describe JobOpportunityHelper do
  context '#human_attribute_enum' do
    it 'translates JobOpportunity enum attributes' do
      helper.human_attribute_enum(
        :job_opportunity,
        :professional_level,
        :junior
      ).should eql('Júnior')

      helper.human_attribute_enum(
        :job_opportunity,
        :professional_level,
        :pleno
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
      ).should eql('Ativa')

      helper.human_attribute_enum(
        :job_opportunity,
        :status,
        :disable
      ).should eql('Inativa')
    end
  end
end
