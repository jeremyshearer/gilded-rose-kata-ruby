# frozen_string_literal: true

class NormalUpdater
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def update
    decrease_quality(item)
    decrease_quality(item) if item.sell_in < 0
  end

  def increase_quality(item)
    item.quality += 1 if item.quality < 50
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0
  end
end

class BrieUpdater < NormalUpdater
  def update
    increase_quality(item)
    increase_quality(item) if item.sell_in < 0
  end
end

class BackstagePassesUpdater < NormalUpdater
  def update
    return item.quality = 0 if item.sell_in < 0

    increase_quality(item)
    increase_quality(item) if item.sell_in < 10
    increase_quality(item) if item.sell_in < 5
  end
end

class GildedRose
  ITEM_CLASS_LOOKUP = {
    'Aged Brie' => BrieUpdater,
    'Backstage passes to a TAFKAL80ETC concert' => BackstagePassesUpdater
  }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      return if item.name == 'Sulfuras, Hand of Ragnaros'

      item.sell_in -= 1
      klass = ITEM_CLASS_LOOKUP.fetch(item.name, NormalUpdater)
      klass.new(item).update
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
