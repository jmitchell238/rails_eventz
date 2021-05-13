class EventsController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.send(events_filter)
  end

  def show
    @likers = @event.likers
    @categories = @event.categories
    if current_user
      @like = current_user.likes.find_by(event_id: @event.id)
    end
  end

  def edit; end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Event successfully updated!'
    else
      render :edit
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: 'Event successfully created!'
    else
      render :new
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, alert: 'Event successfully deleted!'
  end

private
  def event_params
    event_params = params.require(:event).
                   permit(:name, :description, :location, :price, :starts_at,
                          :capacity, :image_file_name, category_ids: [])
  end

  def set_event
    @event = Event.find_by!(slug: params[:id])
  end

  def events_filter
    if params[:filter].in? %w(past free recent)
      params[:filter]
    else
      :upcoming
    end
  end
end
