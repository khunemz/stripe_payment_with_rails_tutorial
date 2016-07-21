class SubscriptionsController < ApplicationController
  before_action :set_subscription , :only => [:show]
  def new
  	plan = Plan.find(params[:plan_id])
  	@subscription = plan.subscriptions.build
  end

  def create
    @subscription = Subscription.new(subscription_params)
    if @subscription.save_with_payment
      redirect_to subscription_path(@subscription), :notice => 'Thank you for subscribing'
    else
      render :new
    end
  end

  def show
  end

  private
  def set_subscription
  	@subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:email , :plan_id , :stripe_customer_token)
  end
end
