class GroupsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  before_filter :set_user
  def unSubscribedGroups
    @latitude, @longitude = *params[:l].split(',')
    # @groups = Group.where(:latitude => @latitude, :longitude => @longitude)
    # @groups = Group.all.select(:name)
    @groups = Group.near([@latitude, @longitude], 1, :units => :km).where.not(id: @user.groups.map(&:id))
    @groups = [] if @groups.empty?
    render json: @groups and return
  end

  def subscribedGroups
    @groups = @user.groups
    @groups = [] if @groups.empty?
    render json: @groups and return
  end

  def create
    @latitude, @longitude = *params[:geoLocation].split(',')

    @user.groups.build(name: params[:name], latitude: @latitude.to_f,
                  longitude: @longitude.to_f, range: params[:range].to_i,
                  open: params[:open] == "true" ? true : false)
    @user.save!
    render text: "Successfully created",  status: :created
  end

  def register
    group = Group.find(params[:group_id])
    @user.groups << group
    @user.save
    render json: group.conversations and return
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end


end
