require 'gcm'
class ConversationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    group = Group.find(params[:group_id])
    group.conversations.build(text: params[:conversation])
    if group.save
      options = {data: {message: params[:conversation]}}
      @gcm.send(group.users.map(&:token), options)
    end
    render text: "Conversation saved Successfully", status: :created
  end

  def list
    group = Group.find(params[:group_id])
    conversations = group.conversations
    render json: conversations and return
  end
end
