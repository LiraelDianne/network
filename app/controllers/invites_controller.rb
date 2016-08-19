class InvitesController < ApplicationController
  def create
  	user = User.find(params[:invited_id])
  	user.invites.create(inviter: User.find(session[:user_id]))
  	redirect_to '/users'
  end

  def delete
  	Invite.destroy(params[:id])
  	redirect_to '/professional_profile'
  end
end
