# This is a patch, future rack should fix this.
module Rack
  class Request
    def content_type
      content_type = @env["CONTENT_TYPE"]
      content_type.nil? || content_type.empty? ? nil : content_type
    end
  end
end

