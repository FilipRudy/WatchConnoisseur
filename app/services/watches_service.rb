# app/services/watches_service.rb
class WatchesService
  def self.filter_watches(watches, params)
    begin
      watches = watches.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
      watches = watches.where(category: params[:category]) if params[:category].present?
      if params[:min_price].present? && params[:max_price].present?
        min_price = params[:min_price].to_i
        max_price = params[:max_price].to_i
        if min_price > max_price
          raise ArgumentError, "Minimum price cannot be greater than maximum price"
        else
          watches = watches.where(price: min_price..max_price)
        end
      end
      watches
    rescue ArgumentError => e
      Rails.logger.error("Error filtering watches: #{e.message}")
      raise e
    rescue => e
      Rails.logger.error("Unexpected error filtering watches: #{e.message}")
      []
    end
  end



  def self.sort_watches(watches, sort_params)
    begin
      if sort_params.present?
        sort_params.split(',').each do |sort_param|
          field, direction = sort_param.split(':')
          watches = watches.order("#{field} #{direction}")
        end
      end
      watches
    rescue => e
      Rails.logger.error("Error sorting watches: #{e.message}")
      []
    end
  end

  def self.paginate_watches(watches, limit, offset)
    begin
      watches.limit(limit).offset(offset)
    rescue => e
      Rails.logger.error("Error paginating watches: #{e.message}")
      []
    end
  end
end
