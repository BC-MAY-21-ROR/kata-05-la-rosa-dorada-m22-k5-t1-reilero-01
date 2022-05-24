# frozen_string_literal: true

# Main class
class GildedRose
  def initialize(items)
    @items = items
  end

  def aged_brie(item)
    item.quality += 1 if (item.name == 'Aged Brie') && (item.quality < 50)
    max_quality(item)
  end

  def sulfuras(item)
    item.quality = item.quality if item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def conjured(item)
    item.quality = item.quality - 2 if item.name == 'Conjured Mana Cake'
    expired_days(item)
    minimum_quality(item)
  end

  def backstage_pass(item)
    return if item.quality == 50

    case item.sell_in
    when 6..10 then item.quality += 2
    when 1..5 then item.quality += 3
    when 0 then item.quality = 0
    end
    max_quality(item)
  end

  def expired_days(item)
    item.quality -= 2 if item.sell_in <= 0
    minimum_quality(item)
  end

  def minimum_quality(item)
    item.quality = 0 if item.quality.negative?
    item.sell_in = 0 if item.sell_in.negative?
  end

  def max_quality(item)
    item.quality = 50 if item.quality > 50
  end

  def normal_items(item)
    item.quality = item.quality - 1
    minimum_quality(item)
    expired_days(item)
  end

  def rules(item)
    case item.name
    when 'Aged Brie' then aged_brie(item)
    when 'Sulfuras, Hand of Ragnaros' then sulfuras(item)
    when 'Backstage passes to a TAFKAL80ETC concert' then backstage_pass(item)
    when 'Conjured Mana Cake' then conjured(item)
    else
      normal_items(item)
      max_quality(item)
    end
  end

  def update_quality
    @items.each do |item|
      item.sell_in -= 1
      rules(item)
    end
  end
end

# cllass generate items objects
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
