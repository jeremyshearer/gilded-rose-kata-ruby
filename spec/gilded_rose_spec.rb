# frozen_string_literal: true

require_relative "../gilded_rose"

RSpec.describe GildedRose do
  describe '#update_quality' do
    it 'updates the sell_in counter' do
      item = Item.new("Normal Item", 5, 5)

      GildedRose.new([item]).update_quality

      expect(item.sell_in).to eq 4
    end

    it 'decreases the sellIn of an item' do
      item = Item.new('Normal Item', 5, 5)
      GildedRose.new([item]).update_quality

      expect(item.sell_in).to eq 4
    end

    it 'decreases the quality of an item as it ages' do
      item = Item.new('Normal Item', 5, 5)

      GildedRose.new([item]).update_quality
      expect(item.quality).to eq 4
    end

    it 'decreases the quality by 1 when sellIn is 1' do
      item = Item.new('Normal Item', 1, 5)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 4
    end

    it 'decreases the quality twice as fast when sellIn is 0' do
      item = Item.new('Normal Item', 0, 5)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 3
    end

    it 'decreases the quality twice as fast when sellIn is -1' do
      item = Item.new('Normal Item', -1, 5)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 3
    end

    it 'decreases the quality twice as fast when sellIn is really old' do
      item = Item.new('Normal Item', -5, 5)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 3
    end

    it 'does not allow the quality to be a negative value' do
      item = Item.new('Normal Item', 5, 0)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 0
    end

    it 'does not allow the quality to be a negative value' do
      item = Item.new('Normal Item', -1, 0)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 0
    end

    it 'does not decrease in quality when the item is Sulfuras' do
      item = Item.new('Sulfuras, Hand of Ragnaros', 0, 80)

      GildedRose.new([item]).update_quality

      expect(item.quality).to eq 80
      expect(item.sell_in).to eq 0
    end

    context 'when the item name is "Aged Brie"' do
      it 'updates the sell_in counter' do
        item = Item.new( 'Aged Brie', 2, 5)

        GildedRose.new([item]).update_quality

        expect(item.sell_in).to eq 1
      end

      it 'increases the quality as sell_in decreases' do
        item = Item.new( 'Aged Brie', 2, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 1
      end

      it 'does not increase the quality above 50' do
        item = Item.new( 'Aged Brie', 2, 50)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 50
      end

      it 'increases the quality by 2 when sell_in is negative' do
        item = Item.new( 'Aged Brie', -1, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 2
      end

      it 'does not increase by quality above 50 when the sell_in is negative' do
        item = Item.new( 'Aged Brie', -1, 49)
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 50
      end
    end

    context 'when the item is "Backstage passes"' do
      it 'updates the sell_in counter' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', 2, 5)

        GildedRose.new([item]).update_quality

        expect(item.sell_in).to eq 1
      end

      it 'increases the quality by 1 when sell_in is 11' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 1
      end

      it 'increases the quality by 2 when sell_in is 10' do
        item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 0)
        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 2
      end

      it 'increases the quality by 2 when sell_in is 8' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 8, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 2
      end

      it 'increases the quality by 2 when sell_in is 6' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 2
      end

      it 'increases the quality by 3 when sell_in is 5' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 0)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 3
      end

      it 'sets the quality to 0 when sell_in is negative' do
        item = Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 50)

        GildedRose.new([item]).update_quality

        expect(item.quality).to eq 0
      end
    end
  end
end
