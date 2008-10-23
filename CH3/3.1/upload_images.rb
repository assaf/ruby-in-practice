require 'rubygems'
require 'aws/s3'
require 'yaml'

fail "Usage:\n  ruby prepare_image.rb <bucket name>\n" unless ARGV.first

puts "Processing images"
Dir['*.jpg'].each do |jpg|
  png = jpg.sub(/jpg$/, 'png')
  puts "#{jpg} => #{png}"
  `convert #{jpg} -resize 800 -bordercolor white -polaroid #{rand(20) -10} #{png}`
end

config = YAML.load(File.read(File.join(Gem.user_home, '.amazonws')))
puts "Connecting to Amazon S3"
AWS::S3::Base.establish_connection!(
  :access_key_id=>config['key_id'],
  :secret_access_key=>config['key_secret'])
AWS::S3::Bucket.create(ARGV.first)
bucket = AWS::S3::Bucket.find(ARGV.first)

upload = Dir['*.png']
upload.each do |image|
  puts "Uploading #{image}"
  AWS::S3::S3Object.store image, open(image),
    bucket.name, :content_type=>'image/png',
    :access=>:public_read
end
urls = upload.map { |image| AWS::S3::S3Object.url_for(image, bucket.name, :authenticated=>false) }
File.open 'images', 'w' do |file|
  file.write urls.join("\n")
end

puts "Completed. Check the file images for list of URLs."
