# frozen_string_literal: true

class EventsController < AuthenticatedController
  before_action :load_event, only: %i[edit update show destroy]

  def index
    @pagy, @events = pagy(event_scope, items: 20)
    @events = @events.decorate
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit
    authorize(@event)
  end

  def create
    @event = event_scope.build event_params
    @event.event_category_id = 1

    if @event.save
      flash[:success] = 'Событие успешно добавлено!'
      redirect_to events_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так!'
      render 'new'
    end
  end

  def update
    authorize(@event)

    if @event.update event_params
      flash[:success] = 'Событие успешно обновлено'
      redirect_to events_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так'
      render 'edit'
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = 'Событие успешно удалено'
    else
      flash[:danger] = 'Что-то пошло не так'
    end

    redirect_to events_path
  end

  private

  def event_scope
    current_user.events
  end

  def event_params
    params.require(:event).permit(:name, :description, :datetime, :whole_day_event)
  end

  def load_event
    @event = event_scope.find(params[:id]).decorate
  end
end
