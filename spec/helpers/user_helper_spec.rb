require 'rails_helper'

describe UserHelper do
  context '#personal_mail?' do
    it 'translates JobOpportunity enum attributes' do
      expect(helper.personal_mail?('test@gmail.com')).to be(true)
      expect(helper.personal_mail?('test@yahoo.com')).to be(true)
      expect(helper.personal_mail?('test@hotmail.com')).to be(true)
      expect(helper.personal_mail?('test@gil.com')).to be(false)
      expect(helper.personal_mail?('test@test.com')).to be(false)
      expect(helper.personal_mail?('test@none.com')).to be(false)
    end
  end
end
