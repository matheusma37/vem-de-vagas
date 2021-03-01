require 'rails_helper'

describe JobOpportunityHelper do
  context '#human_attribute_enum' do
    it 'translates JobOpportunity enum attributes' do
      expect(helper.human_attribute_enum(
               :job_opportunity,
               :professional_level,
               :junior
             )).to eql('Júnior')

      expect(helper.human_attribute_enum(
               :job_opportunity,
               :professional_level,
               :pleno
             )).to eql('Pleno')

      expect(helper.human_attribute_enum(
               :job_opportunity,
               :professional_level,
               :senior
             )).to eql('Sênior')

      expect(helper.human_attribute_enum(
               :job_opportunity,
               :status,
               :enable
             )).to eql('Habilitada')

      expect(helper.human_attribute_enum(
               :job_opportunity,
               :status,
               :disable
             )).to eql('Desabilitada')
    end
  end
end
