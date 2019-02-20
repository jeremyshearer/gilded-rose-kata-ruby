# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'decreases the sellIn of an item' do
      items = [create_item(sell_in: 5)]
      GildedRose.new(items).update_quality
      expect(items[0].sell_in).to eq 4
    end

    it 'decreases the quality of an item as it ages' do
      items = [create_item(sell_in: 5, quality: 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end

    it 'decreases the quality by 1 when sellIn is 1' do
      items = [Item.new('foo', 1, 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end

    it 'decreases the quality twice as fast when sellIn is 0' do
      items = [Item.new('foo', 0, 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 3
    end

    it 'decreases the quality twice as fast when sellIn is -1' do
      items = [Item.new('foo', -1, 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 3
    end

    it 'does not decrease in quality when the item is sulfruas' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 80)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 80
    end

    it 'increases the quality of aged brie as sellIn decreases' do
      items = [Item.new("Aged Brie", 2, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 1
    end
  end
end


def create_item(sell_in: 10, quality: 10, name: "foo")
  Item.new(name, sell_in, quality)
end
