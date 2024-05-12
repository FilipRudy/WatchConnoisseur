class WatchesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    begin
      watches = Watch.all

      watches = WatchesService.filter_watches(watches, params)
      watches = WatchesService.sort_watches(watches, params[:sort])
      watches = WatchesService.paginate_watches(watches, params[:limit], params[:offset])

      render json: watches
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def create
    required_params = [:name, :description, :category, :price, :photo_url]

    if required_params.all? { |param| params[:watch].key?(param) }
      begin
        watch = Watch.new(watch_params)
        watch.user_id = current_user.id

        watch.save
          render json: watch, status: :created
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    else
      render json: { error: "Missing parameters" }, status: :unprocessable_entity
    end
  end

  def update
    begin
      watch = Watch.find(params[:id])
      authorize watch

      watch.update(watch_params.merge(updated_at: Time.current))
        render json: watch, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end



  def destroy
    begin
      watch = Watch.find(params[:id])
      authorize watch

      watch.destroy!
      render json: { message: 'Watch deleted successfully' }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  private

  def watch_params
    params.require(:watch).permit(:name, :description, :category, :price, :photo_url)
  end

end
