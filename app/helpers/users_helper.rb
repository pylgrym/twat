module UsersHelper

    # P288 added:
	#Returns the Gravatar (http://gravatar.com/) for the given user.
	def gravatar_for(user, options = { size: 50 } )
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		# doesn't work - they changed address..
		#gravatar_url = "https://secure.gravatar.com/avatars/#{gravatar_id}.png"
		# this one works:
		#gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png"
		gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
		# next one used to debug/display:
		#image_tag(gravatar_url, alt: gravatar_url, class: "gravatar")
	end

end
