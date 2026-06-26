class GildedRose
  class BaseItem
    SELL_DATE_PASSED_INCREMENT = 2
    DEFAULT_INCREMENT = 1

    attr_reader :item

    def initialize(item)
      @item = item
    end

    def update_quality; end
  end

  class Normal < BaseItem
    def update_quality
      item.decrease_sell_in

      if item.before_sell_date?
        item.decrease_quality
      else
        item.decrease_quality(SELL_DATE_PASSED_INCREMENT)
      end
    end
  end

  class Brie < BaseItem
    def update_quality
      item.decrease_sell_in

      if item.before_sell_date?
        item.increase_quality
      else
        item.increase_quality(SELL_DATE_PASSED_INCREMENT)
      end
    end
  end

  class Sulfuras < BaseItem
  end

  class Backstage < BaseItem
    THREE_X_RANGE = (-Float::INFINITY)..5
    TWO_X_RANGE = 6..10
    THREE_X_INCREMENT = 3
    TWO_X_INCREMENT = 2

    def update_quality
      item.decrease_sell_in

      if item.sell_date_passed?
        item.decrease_quality(item.quality)
      else
        item.increase_quality(backstage_increment_for(item.sell_in))
      end
    end

    private

    def backstage_increment_for(sell_in)
      case sell_in
      when THREE_X_RANGE then THREE_X_INCREMENT
      when TWO_X_RANGE then TWO_X_INCREMENT
      else DEFAULT_INCREMENT
      end
    end
  end

  class Conjured < BaseItem
    SELL_DATE_PASSED_INCREMENT = 4
    DEFAULT_INCREMENT = 2

    def update_quality
      item.decrease_sell_in

      if item.sell_date_passed?
        item.decrease_quality(SELL_DATE_PASSED_INCREMENT)
      else
        item.decrease_quality(DEFAULT_INCREMENT)
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

  def update_quality = @items.each { |item| update_item_quality(item) }

  private

  def update_item_quality(item)
    strategy = STRATEGIES.fetch(item.name, Normal)

    strategy.new(item).update_quality
  end
end

class Item
  attr_reader :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def decrease_quality(qty = 1)
    self.quality -= qty

    self.quality = 0 if quality < 0
  end

  def increase_quality(qty = 1)
    self.quality += qty

    self.quality = 50 if quality > 50
  end

  def decrease_sell_in
    self.sell_in -= 1
  end

  def sell_date_passed? = sell_in.negative?
  def before_sell_date? = sell_in.positive? || sell_in.zero?
  def to_s = "#{name}, #{sell_in}, #{quality}"

  private

  attr_writer :sell_in, :quality
end
