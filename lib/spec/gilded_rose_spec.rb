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
  describe '#sulfuras' do
    it 'quality must not change with time' do
      item = [Item.new('Sulfuras, Hand of Ragnaros', 2, 80)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(80)
    end
  end
  describe '#conjured' do
    it 'quality lowers twice as fast' do
      item = [Item.new('Conjured Mana Cake', 5, 48)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(46)
    end
  end

  describe '#backstage_pass' do
    it 'increase in quality relative to its sellIn value when there are 10 or less days left increase quality by 2' do
      item = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 48)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(50)
    end
  end

  describe 'backstage pass' do
    it 'when there are 5 or less days left increase quality by 3' do
      item = [Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 48)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(50)
    end
  end

  describe 'backstage pass' do
    it ' when there are 0 or less days left quality drops down to 0' do
      item = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 48)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(0)
    end
  end

  describe '#expired_days' do
    it 'quality degrades twice as fast when sell in eq to zero or less' do
      item = [Item.new('Elixir of the Mongoose', 0, 2)]
      gilded_rose = GildedRose.new(item)
      items = gilded_rose.update_quality
      expect(items.first.quality).to eq(0)
    end
  end
end
