class AssignMailer < ApplicationMailer

	def courier_accepted(user)
		user = assign

        mail to:  user.email_address,
        subject: 'PickApp Notification'
	    # headers['X-MC-MergeVars'] = "{\"TYPE\":\"#{@assignment.courier.name}\"}" # variables
	    # headers['X-MC-Template'] = "mine"  # template
	    #  headers['X-MC-AutoText'] = 1 # generate text version
	    # headers['X-MC-InlineCSS'] = "true" # inline css
    end

    def new_package(assign)
    	@notified = assign
    	@notified.each do |x|
    	  mail to:  x.email_address,
          subject: 'PickApp Notification'
   		end
    end
	

end
