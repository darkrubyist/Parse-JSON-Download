require 'fileutils'
require 'json'
require "open-uri"
require 'uri'

class DownloadPhones

	def initialize
		results = File.read('res.json')
		data_hash = JSON.parse(results)

		data_hash.each do |element|
			puts element['sku']
			folder_name = FileUtils.mkdir_p element['sku']

			element['response']['Options'].each do |op|
				op['Spaces'].each do |sp|
					sp['Layers'].each do |lay|

						if lay['OverlayImageUrl'] != nil
							puts lay['OverlayImageUrl']
							download_image(lay['OverlayImageUrl'], folder_name)
						end

						if lay['BackgroundImageUrl'] != nil
							puts lay['BackgroundImageUrl']
							download_image(lay['BackgroundImageUrl'], folder_name)
						end

						if lay['BleedImageUrl'] != nil
							puts lay['BleedImageUrl']
							download_image(lay['BleedImageUrl'], folder_name)
						end
					end
				end
			end	
		end
	end


	def download_image(link, folder)
		uri = URI.parse(link)

		open(link) {|f|
		   File.open("#{folder.first}/#{File.basename(uri.path)}.jpg","wb") do |file|
		     file.puts f.read
		   end
		}
	end

end
x = DownloadPhones.new


# GET VARIANTS

# var settings = {
#   "async": true,
#   "crossDomain": true,
#   "url": "source/api/productvariants/?id",
#   "method": "GET",
#   "headers": {
#     "content-type": "application/json"
#   }
# }
# var variants;
# $.ajax(settings).done(function (response) {
#   variants = response;
# });


# ASSIGN SKUS

# skus = []
# variants.ProductVariants.filter((e)=> {
#     console.log(e.Sku);
#     skus.push(e.Sku)
# });


# GET TEMPLATES

# var templates = [];
# function process(sku, settings) {
#      var data = $.ajax(settings).done(function(resp) {
#           var phoneCase = {
#             response: resp,
#             sku: sku
#           }
#           templates.push(phoneCase);
#      });
# }

# skus.filter((e)=> {
#    if (e.includes("PremiumPhoneCase")) {

#        var settings = {
#           "async": true,
#           "crossDomain": true,
#           "url": "source/api/producttemplates/?recipe...&sku=" + e,
#           "method": "GET",
#           "headers": {
#             "content-type": "application/json"
#           }
#         }
# 		process(e, settings);
#        settings = {}
#    }
# });

# copy(templates)






