require 'rails_helper'

RSpec.describe WatchesService, type: :service do
  describe 'filter_watches' do
    it 'should filter watches by name' do
      watch = create(:watch, name: 'Test Watch')
      watches = WatchesService.filter_watches(Watch.all, name: 'Test Watch')
      expect(watches).to eq([watch])
    end

    it 'should filter watches by category' do
      watch = create(:watch, category: Watch.categories.keys.first)
      watches = WatchesService.filter_watches(Watch.all, category: watch.category)
      expect(watches).to eq([watch])
    end

    it 'should filter watches by price range' do
      watch = create(:watch, price: 75)
      watches = WatchesService.filter_watches(Watch.all, min_price: 50, max_price: 100)
      expect(watches).to eq([watch])
    end

    it 'should return empty array when no watches match the given name' do
      create(:watch, name: 'Test Watch')
      watches = WatchesService.filter_watches(Watch.all, name: 'Non-existent Watch')
      expect(watches).to eq([])
    end

    it 'should return empty array when no watches match the given category' do
      create(:watch, category: Watch.categories.keys.first)
      watches = WatchesService.filter_watches(Watch.all, category: 'Non-existent Category')
      expect(watches).to eq([])
    end

    it 'should return empty array when no watches match the given price range' do
      create(:watch, price: 75)
      watches = WatchesService.filter_watches(Watch.all, min_price: 100, max_price: 200)
      expect(watches).to eq([])
    end

    it 'should raise an error when min_price is greater than max_price' do
      expect {
        WatchesService.filter_watches(Watch.all, min_price: 100, max_price: 50)
      }.to raise_error(ArgumentError)
    end
  end

  describe '.sort_watches' do
    it 'sorts watches by a single field in ascending order' do
      watches = create_list(:watch, 3)
      sorted_watches = WatchesService.sort_watches(Watch.all, 'price:asc')
      expect(sorted_watches).to eq(watches.sort_by(&:price))
    end

    it 'sorts watches by multiple fields' do
      create_list(:watch, 3)
      sorted_watches = WatchesService.sort_watches(Watch.all, 'price:desc,name:asc')
      expect(sorted_watches.map(&:attributes)).to eq(Watch.all.order(price: :desc, name: :asc).map(&:attributes))
    end
  end

  describe '.paginate_watches' do
    it 'paginates watches correctly' do
      watches = create_list(:watch, 10)
      limit = 5
      offset = 0
      paginated_watches = WatchesService.paginate_watches(Watch.all, limit, offset)
      expect(paginated_watches.count).to eq(limit)
      expect(paginated_watches).to eq(watches.first(limit))
    end
  end
end
