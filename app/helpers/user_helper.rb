module UserHelper
  PERSONAL_MAIL_DOMAINS = %w[@gmail.com @outlook.com @icloud.com @yahoo.com
                             @protonmail.com @fastmail.com @bol.com @uol.com
                             @yandex.com @tutanota.com @lockbin.com @qq.com
                             @aol.com @mail.com @gmx.com @zohomail.com
                             @excite.com @lycos.com @mail.ru @inbox.ru
                             @list.ru @bk.ru @internet.ru @mailfence.com
                             @rackspace.com @rediffmail.com @runbox.com
                             @tiscali.com @hushmail.com @example.com @hotmail.com]

  def personal_mail?(mail)
    PERSONAL_MAIL_DOMAINS.include?(mail.scan(/(?:@)\w+\.\w{2,4}/).first)
  end
end
