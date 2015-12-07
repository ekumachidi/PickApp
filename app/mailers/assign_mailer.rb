class AssignMailer < ApplicationMailer

	def courier_accepted(package)
        @package = package
        mail to:  @package.user.email,
        subject: 'PickApp Notification'
	    # headers['X-MC-MergeVars'] = "{\"TYPE\":\"#{@assignment.courier.name}\"}" # variables
	    # headers['X-MC-Template'] = "mine"  # template
	    #  headers['X-MC-AutoText'] = 1 # generate text version
	    # headers['X-MC-InlineCSS'] = "true" # inline css
    end

    def new_package(package)
    	@notified = assign
        @package = package
    	@notified.each do |x|
    	  mail to:  x.email_address,
          subject: 'PickApp Notification'
   		end
    end
	

end
