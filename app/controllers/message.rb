class Message

    def courier_notification(couriers, package)
		 couriers.each do |courier| 
          body = "Package with weight: #{package.weight}, location: #{package.location}, destination: #{package.destination} is close to you. Enter url to accept";
          number = "+233#{courier.phone}" 
          credentials(body, number)
         end
	end

	def package_accepted(courier, user)
		body = "We are glad to let you know that courier with name: #{courier.profile.name rescue 'courier'} and contact: #{@courier.profile.phone rescue 'number'} has accepted to deliver your package. "
		number = "+233#{user.profile.phone rescue '546590509'}"
		credentials(body, number)
	end

	def package_delivered(entity)
		body = "We got the notification that your package has been delivered, Call: 0546590509  if you have any problem"
		number = "+233#{entity.profile.phone rescue '546590509'}"
		credentials(body, number)

	end
    
    

	def credentials(body,number)
		twilio_client= Twilio::REST::Client.new  "AC2d487be9fecde43cc622b6c22b6a9ddf", "992ce6ad360c902a076aa8a336b2137b"
		twilio_client.account.sms.messages.create(
            from: "+18442948236",
            to:   number,
            body: body,
         )
	end

end