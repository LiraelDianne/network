class NetworksController < ApplicationController
  def create
  	invite = Invite.find(params[:invite_id])
  	invite.user.networks.create(friend: invite.inviter)
  	invite.inviter.networks.create(friend: invite.user)
  	invite.destroy
  	redirect_to '/professional_profile'
  end

  def delete
    network = Network.find(params[:id])
  	user = User.find(session[:user_id])
  	friend = network.friend
  	user.networks.where(friend: friend).take.destroy
  	friend.networks.where(friend: user).take.destroy
  	redirect_to '/professional_profile'
  end
end
