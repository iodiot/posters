require 'RMagick'

module Toolkit
	def censore_poster_images(posters)
		Dir.chdir 'public/images/posters' do
			posters.each do |p|
				if p.censored 
					image = Magick::Image::read(p.image).first
					pixelated = image.scale(0.05).scale(20)
					pixelated.format = 'PNG'
					s = "#{p.image.gsub(/.jpg/, '.png')}"
					pixelated.write("CENSORED_#{s}")
					puts "#{s} => CENSORED_#{s}"
				end
			end
		end
	end
end
