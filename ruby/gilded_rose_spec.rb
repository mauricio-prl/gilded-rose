require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  subject(:update_quality) do
    described_class.new([item]).update_quality
  end

  let(:item) { Item.new(name, sell_in, quality) }

  before { update_quality }

  describe 'normal items' do
    let(:name) { 'foo' }
    let(:sell_in) { 10 }
    let(:quality) { 20 }

    it { expect(item.sell_in).to eq(9) }
    it { expect(item.quality).to eq(19) }

    context 'after sell date' do
      let(:sell_in) { 0 }
      let(:quality) { 20 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(18) }
    end

    context 'when quality is already 0' do
      let(:sell_in) { 5 }
      let(:quality) { 0 }

      it { expect(item.sell_in).to eq(4) }
      it { expect(item.quality).to eq(0) }
    end

    context 'when quality is 0 after sell date' do
      let(:sell_in) { 0 }
      let(:quality) { 0 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(0) }
    end

    context 'name' do
      let(:sell_in) { 10 }
      let(:quality) { 20 }

      it { expect(item.sell_in).to eq(9) }
      it { expect(item.name).to eq('foo') }
    end
  end

  describe 'Aged Brie' do
    let(:name) { 'Aged Brie' }
    let(:sell_in) { 10 }
    let(:quality) { 20 }

    it { expect(item.sell_in).to eq(9) }
    it { expect(item.quality).to eq(21) }

    context 'after sell date' do
      let(:sell_in) { 0 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(22) }
    end

    context 'at max quality' do
      let(:sell_in) { 5 }
      let(:quality) { 50 }

      it { expect(item.sell_in).to eq(4) }
      it { expect(item.quality).to eq(50) }
    end
  end

  describe 'Sulfuras' do
    let(:name) { 'Sulfuras, Hand of Ragnaros' }
    let(:sell_in) { 0 }
    let(:quality) { 80 }

    it { expect(item.sell_in).to eq(0) }
    it { expect(item.quality).to eq(80) }
  end

  describe 'Backstage passes' do
    let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }
    let(:sell_in) { 15 }
    let(:quality) { 20 }

    it { expect(item.sell_in).to eq(14) }
    it { expect(item.quality).to eq(21) }

    context 'when sell_in is 10 days or less' do
      let(:sell_in) { 10 }

      it { expect(item.sell_in).to eq(9) }
      it { expect(item.quality).to eq(22) }
    end

    context 'when sell_in is 5 days or less' do
      let(:sell_in) { 5 }

      it { expect(item.sell_in).to eq(4) }
      it { expect(item.quality).to eq(23) }
    end

    context 'after the concert' do
      let(:sell_in) { 0 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(0) }
    end

    context 'near max quality' do
      let(:sell_in) { 5 }
      let(:quality) { 49 }

      it { expect(item.sell_in).to eq(4) }
      it { expect(item.quality).to eq(50) }
    end
  end

  describe 'Conjured items' do
    let(:name) { 'Conjured Mana Cake' }
    let(:sell_in) { 10 }
    let(:quality) { 20 }

    it { expect(item.quality).to eq(18) }
    it { expect(item.sell_in).to eq(9) }

    context 'after sell date' do
      let(:sell_in) { 0 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(16) }
    end

    context 'near zero quality' do
      let(:sell_in) { 0 }
      let(:quality) { 3 }

      it { expect(item.sell_in).to eq(-1) }
      it { expect(item.quality).to eq(0) }
    end
  end

  describe 'global quality rules' do
    let(:name) { 'Aged Brie' }
    let(:sell_in) { 2 }
    let(:quality) { 50 }

    it { expect(item.sell_in).to eq(1) }
    it { expect(item.quality).to be <= 50 }

    context 'Sulfuras' do
      let(:name) { 'Sulfuras, Hand of Ragnaros' }
      let(:sell_in) { 5 }
      let(:quality) { 80 }

      it { expect(item.sell_in).to eq(5) }
      it { expect(item.quality).to eq(80) }
    end
  end
end
