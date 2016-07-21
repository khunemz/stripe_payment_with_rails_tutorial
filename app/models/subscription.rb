class Subscription < ApplicationRecord
	attr_accessor :stripe_card_token
	belongs_to :plan
	validates_presence_of :plan_id
	validates_presence_of :email

	def save_with_payment
		if valid?
			customer = Stripe::Customer.create(description: email, plan: plan_id, source: stripe_card_token)
			self.stripe_customer_token = customer.id
			save!
		end
	end
end
