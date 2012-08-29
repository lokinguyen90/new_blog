module ApplicationHelper
	def title
		base_title="Static pages"
		if(@title.nil?)
			base_title
		else
			base_title + " | " + @title
		end
	end
	
	def logo
		image_tag("http://rubyonrails.org/images/rails.png", :alt => "Sample App", :class => "round")
	end

end
