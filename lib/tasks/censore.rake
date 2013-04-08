namespace :admin do
	desc 'Censore poster images'
	task :censore => :environment do
		include Toolkit
		censore_poster_images(Poster.all)
	end
end
