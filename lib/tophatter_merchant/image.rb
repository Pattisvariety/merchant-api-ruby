module TophatterMerchant
  class Image < Resource
    attr_accessor :id, :fingerprint, :url

    class << self
      # request = RestClient::Request.new(method: :get, url: 'https://img0.etsystatic.com/101/0/7856452/il_fullxfull.882030160_r0tn.jpg')
      # response = request.execute
      # File.open('/tmp/foo.jpg', 'w') { |file| file.write(response.body) }
      # ap TophatterMerchant::Image.create(File.open('/tmp/foo.jpg')).to_h
      def create(file)
        Image.new post(url: "#{path}.json", params: { data: file })
      end

      protected

      def path
        super + '/images'
      end
    end
  end
end
