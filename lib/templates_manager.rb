class TemplatesManager

  # this methods replaces all instances of "{xxxx}" in the html
  #with value of xxxx key of vars hash
  #using: render_variables(html, {:client_name => 'Paul Ser'}
  def self.render_variables(html, vars)
    doc = Nokogiri::HTML(html)
    doc.xpath('//*[contains(child::text(), "}")][contains(child::text(), "{")]').each do |elem|
      var_name = elem.content.match(/\{(.*)\}/m)[1].strip
      elem.content = elem.content.gsub(/\{.+\}/, vars[var_name.to_sym].to_s) if !vars[var_name.to_sym].nil?
    end
    doc.to_html
  end

  def self.build_rel_assets_links(data)
    raise "Empty data hash" if data.empty?
    data.each do |key, val|

      #normalizing stylesheets and images links to include template folder name in the URL
      doc = Nokogiri::HTML(val)

      doc.css("link[rel='stylesheet']").each do |style|
        style['href'] = "/#{key}/#{style['href']}"
      end

      doc.css("img").each do |img|
        img['src'] = "/#{key}/#{img['src']}"
      end


      data[key] = doc.to_html
    end
  end

end