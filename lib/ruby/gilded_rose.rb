# frozen_string_literal: true

class GildedRose
  def initialize(items)
    @items = items
  end


  def aged_brie(item)
    if (item.name == 'Aged Brie') && (item.quality < 50)
      item.quality += 1
    end
  end

  def sulfuras(item)
    if (item.name == 'Sulfuras, Hand of Ragnaros')
      item.quality = item.quality
    end
  end
  def conjured(item)
    if (item.name == 'Conjured Mana Cake')
      item.quality = item.quality - 2
    end
  end

  def backstage_pass(item)
    if item.quality == 50
      return
    end
    case item.sell_in
    when 6..10 then item.quality += 2
    when 1..5 then item.quality += 3
    when 0 then item.quality = 0
    end
  end
  
  def update_quality
    @items.each do |item|
      if (item.name != 'Aged Brie') && (item.name != 'Backstage passes to a TAFKAL80ETC concert')
        if item.quality.positive? && ((item.name != 'Sulfuras, Hand of Ragnaros') && (item.name != 'Conjured Mana Cake')) # detectar conjured
          item.quality = item.quality - 1
        end
      elsif item.quality < 50
        item.quality = item.quality + 1
        if item.name == 'Backstage passes to a TAFKAL80ETC concert'
          item.quality = item.quality + 1 if item.sell_in < 11 && (item.quality < 50)
          item.quality = item.quality + 1 if item.sell_in < 6 && (item.quality < 50)
        end
      end
      if (item.name != 'Sulfuras, Hand of Ragnaros') && (item.name != 'Conjured Mana Cake') # detectar conjured
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in.negative?
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
            item.quality = item.quality - 1 if item.quality.positive? && (item.name != 'Sulfuras, Hand of Ragnaros')
          else
            item.quality = item.quality - item.quality
          end
        elsif item.quality < 50
          item.quality = item.quality + 1
        end
      end
      next unless (item.name == 'Conjured Mana Cake') && item.quality.positive? # conjurado

      item.quality = item.quality - 2
      item.sell_in = item.sell_in - 1
    end
  end
end

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
