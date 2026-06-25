require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:updated_item) do
    item = Item.new(name, sell_in, quality)
    GildedRose.new([item]).update_quality
    item
  end

  describe 'normal items' do
    context 'sell_in updates' do
      let(:name) { 'foo' }
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(updated_item.sell_in).to eq(9) }
    end

    context 'before sell date' do
      let(:name) { 'foo' }
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(19) }
    end

    context 'after sell date' do
      let(:name) { 'foo' }
      let(:sell_in) { 0 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(18) }
    end

    context 'when quality is already 0' do
      let(:name) { 'foo' }
      let(:sell_in) { 5 }
      let(:quality) { 0 }

      it { expect(updated_item.quality).to eq(0) }
    end

    context 'when quality is 0 after sell date' do
      let(:name) { 'foo' }
      let(:sell_in) { 0 }
      let(:quality) { 0 }

      it { expect(updated_item.quality).to eq(0) }
    end

    context 'name' do
      let(:name) { 'foo' }
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(updated_item.name).to eq('foo') }
    end
  end

  describe 'Aged Brie' do
    context 'before sell date' do
      let(:name) { 'Aged Brie' }
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(21) }
    end

    context 'after sell date' do
      let(:name) { 'Aged Brie' }
      let(:sell_in) { 0 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(22) }
    end

    context 'at max quality' do
      let(:name) { 'Aged Brie' }
      let(:sell_in) { 5 }
      let(:quality) { 50 }

      it { expect(updated_item.quality).to eq(50) }
    end
  end

  describe 'Sulfuras' do
    let(:name) { 'Sulfuras, Hand of Ragnaros' }
    let(:sell_in) { 0 }
    let(:quality) { 80 }

    it { expect(updated_item.sell_in).to eq(0) }
    it { expect(updated_item.quality).to eq(80) }
  end

  describe 'Backstage passes' do
    let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

    context 'when sell_in is more than 10' do
      let(:sell_in) { 15 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(21) }
    end

    context 'when sell_in is 10 days or less' do
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(22) }
    end

    context 'when sell_in is 5 days or less' do
      let(:sell_in) { 5 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(23) }
    end

    context 'after the concert' do
      let(:sell_in) { 0 }
      let(:quality) { 20 }

      it { expect(updated_item.quality).to eq(0) }
    end

    context 'near max quality' do
      let(:sell_in) { 5 }
      let(:quality) { 49 }

      it { expect(updated_item.quality).to eq(50) }
    end
  end

  describe 'Conjured items' do
    let(:name) { 'Conjured Mana Cake' }

    context 'before sell date' do
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      xit { expect(updated_item.quality).to eq(18) }
      it { expect(updated_item.sell_in).to eq(9) }
    end

    context 'after sell date' do
      let(:sell_in) { 0 }
      let(:quality) { 20 }

      xit { expect(updated_item.quality).to eq(16) }
    end

    context 'near zero quality' do
      let(:sell_in) { 0 }
      let(:quality) { 3 }

      xit { expect(updated_item.quality).to eq(0) }
    end
  end

  describe 'global quality rules' do
    context 'non-legendary items' do
      let(:name) { 'Aged Brie' }
      let(:sell_in) { 2 }
      let(:quality) { 50 }

      it { expect(updated_item.quality).to be <= 50 }
    end

    context 'Sulfuras' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }
      let(:sell_in) { 5 }
      let(:quality) { 80 }

      it { expect(updated_item.quality).to eq(80) }
    end
  end
end
