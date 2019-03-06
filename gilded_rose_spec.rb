# frozen_string_literal: true

require File.join(File.dirname(__FILE__), 'gilded_rose')

RSpec.describe GildedRose do
  describe '#update_quality' do
    it 'decreases the sellIn of an item' do
      normal_item = create_item(sell_in: 5)
      gilded_rose = GildedRose.new([normal_item])
      gilded_rose.update_quality

      expect(normal_item.sell_in).to eq 4
    end

    it 'decreases the quality of an item as it ages' do
      items = [create_item(quality: 5)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 4
    end

    it 'decreases the quality by 1 when sellIn is 1' do
      items = [create_item(sell_in: 1, quality: 5)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 4
    end

    it 'decreases the quality twice as fast when sellIn is 0' do
      items = [create_item(sell_in: 0, quality: 5)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 3
    end

    it 'decreases the quality twice as fast when sellIn is -1' do
      items = [create_item(sell_in: -1, quality: 5)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 3
    end

    it 'decreases the quality twice as fast when sellIn is really old' do
      items = [create_item(sell_in: -5, quality: 5)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 3
    end

    it 'does not allow the quality to be a negative value' do
      items = [create_item(sell_in: 5, quality: 0)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 0
    end

    it 'does not allow the quality to be a negative value' do
      items = [create_item(sell_in: -1, quality: 0)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 0
    end

    it 'does not decrease in quality when the item is Sulfuras' do
      items = [create_item(name: 'Sulfuras, Hand of Ragnaros', sell_in: 0, quality: 80)]

      GildedRose.new(items).update_quality

      expect(items[0].quality).to eq 80
      expect(items[0].sell_in).to eq 0
    end

    context 'when the item name is "Aged Brie"' do
      it 'increases the quality as sell_in decreases' do
        items = [Item.new('Aged Brie', 2, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 1
      end

      it 'does not increase the quality above 50' do
        items = [Item.new('Aged Brie', 2, 50)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 50
      end

      it 'increases the quality by 2 when sell_in is negative' do
        items = [Item.new('Aged Brie', -1, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 2
      end
    end

    context 'when the item is "Backstage passes"' do
      it 'increases the quality by 1 when sell_in is 11' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, 11, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 1
      end

      it 'increases the quality by 2 when sell_in is 10' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, 10, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 2
      end

      it 'increases the quality by 2 when sell_in is 8' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, 8, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 2
      end

      it 'increases the quality by 2 when sell_in is 6' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, 6, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 2
      end

      it 'increases the quality by 3 when sell_in is 5' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, 5, 0)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 3
      end

      it 'sets the quality to 0 when sell_in is negative' do
        items = [Item.new(GildedRose::BACKSTAGE_PASSES, -1, 50)]

        GildedRose.new(items).update_quality

        expect(items[0].quality).to eq 0
      end
    end
  end
end

def create_item(sell_in: 10, quality: 10, name: 'foo')
  Item.new(name, sell_in, quality)
end
