PickApp
Overview: A complete end to end courier service app implemented in ruby.
A user buys an item from their any merchant or vendor, comes on our platform. gives us details of the purchase; we get a courier pass on those details to them and then have the irem delivered to the user.
Entities:
Users
⦁	Courier
⦁	Admin
⦁	Packages
⦁	Vendor
⦁	Payment
Models:
⦁	User - manages authentication
⦁	Profile - Holds profile info of users
⦁	Roles - Has the different roles supported on the platform
⦁	Packages - Info about packages
⦁	Courier - Maps users to courier
⦁	Assignmment - Assign packages to courier
⦁	History - Package history, User history, Courier history
Fields on Models:
Assignments: - 	user_id
				package_id
				courier_id

Packages: -		tracking_code
				weight
				vendor
				location
				destination
				recipient
				r_contact
				due_at
				status
				dispatch
				assigned
				latitude
				longitude
				user_id

profiles: -		user_id
				name
				address
				phone
				latitude
				longitude

Suggested flow
1.	User signs up
2.	Fills profile
3.	For courier, admin needs to approve thier account and change their role
4.	User adds packages
5.	Courier gets notified and can accept delivery schedule
6.	Courier the location of packages on a map


