# This is a patch, future rack should fix this.
# http://gist.github.com/519415#file_rack_content_type_patch.rb

module Rack
  class Request
    def content_type
      content_type = @env['CONTENT_TYPE']
      content_type.nil? || content_type.empty? ? nil : content_type
    end

    def media_type
      puts " ******************* I'm in your method"
      if content_type.nil? || content_type.empty? 
        nil
      else
        content_type && content_type.split(/\s*[;,]\s*/, 2).first.downcase
      end
    end
  end
end

