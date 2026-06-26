class GildedRose
  class Normal
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality
      item.decrease_sell_in

      if item.sell_in.positive?
        item.decrease_quality
      else
        item.decrease_quality(2)
      end
    end
  end

  class Brie
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality
      item.decrease_sell_in

      if item.sell_in.positive?
        item.increase_quality
      else
        item.increase_quality(2)
      end
    end
  end

  class Sulfuras
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality; end
  end

  class Backstage
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality
      item.decrease_sell_in

      if item.sell_in.negative?
        item.decrease_quality(item.quality)
      elsif item.sell_in <= 5
        item.increase_quality(3)
      elsif item.sell_in <=10
        item.increase_quality(2)
      else
        item.increase_quality
      end
    end
  end

  class Conjured
    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality
      item.decrease_sell_in

      if item.sell_in.negative?
        item.decrease_quality(4)
      else
        item.decrease_quality(2)
      end
    end
  end

  STRATEGIES = { 'Aged Brie' => Brie,
                 'Sulfuras, Hand of Ragnaros' => Sulfuras,
                 'Backstage passes to a TAFKAL80ETC concert' => Backstage,
                 'Conjured Mana Cake' => Conjured }.freeze

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { |item| update_item_quality(item) }
  end

  private

  def update_item_quality(item)
    strategy = STRATEGIES.fetch(item.name, Normal)
    strategy.new(item).update_quality
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def decrease_quality(qty = 1)
    @quality -= qty

    @quality = 0 if @quality < 0
  end

  def increase_quality(qty = 1)
    @quality += qty

    @quality = 50 if @quality > 50
  end

  def decrease_sell_in
    @sell_in -= 1
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
