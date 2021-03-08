require 'rails_helper'

describe ApplicationHelper do
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

    it 'translates JobApplication enum attributes' do
      expect(helper.human_attribute_enum(
               :job_application,
               :status,
               :sended
             )).to eql('Enviada')
      expect(helper.human_attribute_enum(
               :job_application,
               :status,
               :saw
             )).to eql('Vista')
      expect(helper.human_attribute_enum(
               :job_application,
               :status,
               :responded
             )).to eql('Respondida')
      expect(helper.human_attribute_enum(
               :job_application,
               :status,
               :refused
             )).to eql('Recusada')
      expect(helper.human_attribute_enum(
               :job_application,
               :status,
               :closed
             )).to eql('Finalizada')
    end
  end
end
