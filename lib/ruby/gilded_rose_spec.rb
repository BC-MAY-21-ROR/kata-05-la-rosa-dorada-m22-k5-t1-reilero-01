# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end
  end

  describe '#aged_brie' do
    it 'quality increase 1 point each day' do
      item = [Item.new('Aged Brie', 2, 0)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(1)
    end
  end
end
