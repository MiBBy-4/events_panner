# frozen_string_literal: true

class EventCategoriesController < AuthenticatedController
  before_action :load_event_category, only: %i[edit update destroy]

  def index
    @pagy, @event_categories = pagy(event_category_scope)
  end

  def new
    @event_category = EventCategory.new
  end

  def edit; end

  def create
    @event_category = event_category_scope.build(event_category_params)

    if @event_category.save
      flash[:success] = 'Категория успешно добавлена!'
      redirect_to event_categories_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так!'
      render 'new'
    end
  end

  def update
    if @event_category.update(event_category_params)
      flash[:success] = 'Категория успешно обновлена'
      redirect_to event_categories_path
    else
      flash.now[:danger] = 'К сожалению что-то пошло не так'
      render 'edit'
    end
  end

  def destroy
    if @event_category.destroy
      flash.now[:success] = 'Категория успешно удалена'
    else
      flash.now[:danger] = 'Что-то пошло не так'
    end

    redirect_to event_categories_path
  end

  private

  def event_category_scope
    current_user.event_categories
  end

  def event_category_params
    params.require(:event_category).permit(:name)
  end

  def load_event_category
    @event_category = event_category_scope.find(params[:id])
  end
end
