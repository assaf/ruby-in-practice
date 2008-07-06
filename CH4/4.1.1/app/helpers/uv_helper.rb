require 'uv'

module UvHelper
  def code(code, format='xhtml', syntax='ruby',
           line_numbers=false, theme='amy')
    unless File.exist?("#{RAILS_ROOT}/public/stylesheets/syntax")
      copy_files
    end

    Uv.parse(code, format, syntax, line_numbers, theme)
  end

private

  def copy_files
    Uv.copy_files 'xhtml', "#{RAILS_ROOT}/public/stylesheets"
    File.rename "#{RAILS_ROOT}/public/stylesheets/css/", 
                "#{RAILS_ROOT}/public/stylesheets/syntax/"
  end
 
  def theme_stylesheet(theme='amy')
    stylesheet_link_tag "syntax/#{theme}"
  end
end
