module ValidatesUrl
 
  def validates_url(attribute = :url)
    validates_presence_of attribute
    validates_length_of attribute, :minimum => 12
    validates_format_of attribute, :with => /^((http|https):(([A-Za-z0-9$_.+!*(),;\/?:@&~=-])|%[A-Fa-f0-9]{2}){2,}(#([a-zA-Z0-9][a-zA-Z0-9$_.+!*(),;\/?:@&~=%-]*))?([A-Za-z0-9$_+!*();\/?:~-]))/, :message => "isn't a valid URL."
  end

end

ActiveRecord::Base.extend ValidatesUrl
