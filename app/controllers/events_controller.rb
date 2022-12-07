# frozen_string_literal: true

class EventsController < AuthenticatedController
  before_action :load_event, only: %i[edit update show destroy]

  def index
    @query = event_scope.includes(:event_category).ransack(params[:q])
    @pagy, @events = pagy(@query.result(distinct: true), items: 20)
    @events = @events.decorate
  end

  def show
    @weather = Events::Weather::Receive.call(@event).value
  end

  def new
    @event = Event.new
  end

  def edit
    authorize(@event)
  end

  def create
    @event = event_scope.build(event_params)
    authorize(@event)

    if Events::Create.call(@event, event_params).success?
      flash[:success] = 'Событие успешно добавлено!'
      redirect_to events_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так!'
      render 'new'
    end
  end

  def update
    authorize(@event)

    if Events::Update.call(@event, event_params).success?
      flash[:success] = 'Событие успешно обновлено'
      redirect_to events_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так'
      render 'edit'
    end
  end

  def destroy
    if Events::Destroy.call(@event).success?
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
    params.require(:event).permit(:name, :description, :datetime, :event_category_id, :whole_day_event, :city,
                                  :remind_at)
  end

  def load_event
    @event = event_scope.find(params[:id]).decorate
  end
end
