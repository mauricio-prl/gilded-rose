class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each { |item| update_item_quality(item) }
  end

  private

  def update_item_quality(item)
    case item.name
    when 'Aged Brie' then brie_quality(item)
    when 'Sulfuras, Hand of Ragnaros' then sulfuras_quality(item)
    when 'Backstage passes to a TAFKAL80ETC concert' then backstage_quality(item)
    when 'Conjured Mana Cake' then conjured_quality(item)
    else normal_quality(item)
    end
  end

  def brie_quality(item)
    item.decrease_sell_in

    if item.sell_in.positive?
      item.increase_quality
    else
      item.increase_quality(2)
    end
  end

  def sulfuras_quality(item); end

  def backstage_quality(item)
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

  def conjured_quality(item)
    item.decrease_sell_in

    if item.sell_in.negative?
      item.decrease_quality(4)
    else
      item.decrease_quality(2)
    end
  end

  def normal_quality(item)
    item.decrease_sell_in

    if item.sell_in.positive?
      item.decrease_quality
    else
      item.decrease_quality(2)
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
