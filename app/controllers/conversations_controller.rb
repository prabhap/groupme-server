require 'gcm'
class ConversationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    group = Group.find(params[:group_id])
    group.conversations.build(text: params[:conversation], user: User.find(params[:user_id]))
    if group.save
      options = {data: {message: params[:conversation], group_name: group.name}}
      @gcm.send(group.users.where.not(id: params[:user_id]).map(&:token), options)
    end
    render text: "Conversation saved Successfully", status: :created
  end

  def list
    group = Group.find(params[:group_id])
    conversations = group.conversations
    render json: conversations and return
  end
end
