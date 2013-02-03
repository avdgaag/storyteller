Rails.application.config.generators do |g|
  g.template_engine     :haml
  g.test_framework      :rspec, fixture: true, fixture_replacement: :factory_girl
  g.view_specs          false
  g.helper_specs        false
  g.helper              false
  g.javascripts         false
  g.stylesheets         false
  g.fixture_replacement :factory_girl
  g.assets              false
end
