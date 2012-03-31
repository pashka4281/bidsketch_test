unprocessed_content = {}

Dir.glob(File.join(RAILS_ROOT, 'public', '*', '*.html')).collect do |x|
  file = File.open(x)
  template_name = File.dirname(file.path).split('/').last
  unprocessed_content[template_name] = file.read()
end

STATIC_TEMPLATES = TemplatesManager.build_rel_assets_links(unprocessed_content)