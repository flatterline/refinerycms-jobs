if defined?(Refinery::User)
  Refinery::User.all.each do |user|
    if user.plugins.where(:name => 'refinerycms_jobs').blank?
      user.plugins.create(:name => "refinerycms_jobs",
                          :position => (user.plugins.maximum(:position) || -1) +1)
    end
  end
end

if defined?(Refinery::Page) and !Refinery::Page.exists?(:link_url => (url = Refinery::Jobs.page_url))
  page = Refinery::Page.create(
    :title => "Jobs",
    :link_url => url,
    :deletable => false,
    :menu_match => "^#{url}?(\/|\/.+?|)$"
  )

  Refinery::Pages.default_parts.each_with_index do |default_page_part, index|
    page.parts.create(:title => default_page_part, :body => nil, :position => index)
  end
end

(Refinery::Jobs::Setting.methods.sort - Refinery::Setting.methods).each do |setting|
  Refinery::Jobs::Setting.send(setting) if setting.to_s !~ /=\z/
end
