require 'rubygems'
require 'uri'
require 'net/https'
require 'xmlsimple'
require 'md5'

def send_order(url, data)
  if Hash === data
    data = XmlSimple.xml_out(data, 'noattr'=>true, 'contentkey'=>'sku',
                             'xmldeclaration'=>true, 'rootname'=>'order')
  end

  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == 'https'

  headers = { 'Content-Type'=>'application/xml',
    'Content-Length'=>data.size.to_s,
    'Content-MD5'=>Digest::MD5.hexdigest(data) }

  post = Net::HTTP::Post.new(uri.path, headers)
  post.basic_auth uri.user, uri.password if uri.user
  response = http.request post, data

  case response
    when Net::HTTPCreated; response['Location']
    when Net::HTTPSuccess; nil
    else response.error!
  end
end

