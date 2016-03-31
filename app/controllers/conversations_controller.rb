class ConversationsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    group = Group.find(params[:group_id])
    group.conversations.build(text: params[:conversation])
    group.save
    render text: "Conversation saved Successfully", status: :created
  end

  def list
    group = Group.find(params[:group_id])
    conversations = group.conversations
    render json: conversations and return
  end
end
