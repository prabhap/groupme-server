class GroupsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def index
    @latitude, @longitude = *params[:l].split(',')
    # @groups = Group.where(:latitude => @latitude, :longitude => @longitude)
    # @groups = Group.all.select(:name)
    @groups = Group.near([@latitude, @longitude], 1, :units => :km).select(:name, :id)
    @groups = [] if @groups.empty?
    render json: @groups and return
  end

  def create
    @latitude, @longitude = *params[:geoLocation].split(',')

    Group.create(name: params[:name], latitude: @latitude.to_f,
                  longitude: @longitude.to_f, range: params[:range].to_i,
                  open: params[:open] == "true" ? true : false)
    render text: "Successfully created",  status: :created
  end

  def register
    user = User.find(params[:user_id])
    group = Group.find(params[:group_id])
    user.subscribed_groups << group
    user.save
    render group.conversations and return
  end

end
