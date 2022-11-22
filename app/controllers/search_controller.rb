# frozen_string_literal: true

class SearchController < AuthenticatedController
  def index
    @query = current_user.events.includes(:event_category).ransack(params[:q])
    @pagy, @events = pagy(@query.result(distinct: true))
    @events = @events.decorate
  end
end
