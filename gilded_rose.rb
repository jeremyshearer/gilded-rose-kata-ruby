# frozen_string_literal: true

class GildedRose
  SULFURAS = 'Sulfuras, Hand of Ragnaros'
  AGED_BRIE = 'Aged Brie'
  BACKSTAGE_PASSES = 'Backstage passes to a TAFKAL80ETC concert'

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      return if item.name == SULFURAS
      case item.name
      when AGED_BRIE
        increase_quality(item)
      when BACKSTAGE_PASSES
        increase_quality(item) if item.sell_in < 11
        increase_quality(item) if item.sell_in < 6
        increase_quality(item)
      else
        decrease_quality(item)
      end

      item.sell_in = item.sell_in - 1

      return if item.sell_in >= 0

      if item.name == AGED_BRIE
        increase_quality(item)
      elsif item.name == BACKSTAGE_PASSES
        item.quality = 0
      else
        decrease_quality(item)
      end
    end
  end

  private

  def increase_quality(item)
    return if item.quality >= 50

    item.quality += 1
  end

  def decrease_quality(item)
    return if item.quality <= 0

    item.quality -= 1
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
