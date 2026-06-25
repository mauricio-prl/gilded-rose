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
    else normal_quality(item)
    end

    #######

    # if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
    #   if item.quality > 0
    #     if item.name != "Sulfuras, Hand of Ragnaros"
    #       item.quality = item.quality - 1
    #     end
    #   end
    # else
    #   if item.quality < 50
    #     item.quality = item.quality + 1
    #     if item.name == "Backstage passes to a TAFKAL80ETC concert"
    #       if item.sell_in < 11
    #         if item.quality < 50
    #           item.quality = item.quality + 1
    #         end
    #       end
    #       if item.sell_in < 6
    #         if item.quality < 50
    #           item.quality = item.quality + 1
    #         end
    #       end
    #     end
    #   end
    # end
    # if item.name != "Sulfuras, Hand of Ragnaros"
    #   item.sell_in = item.sell_in - 1
    # end
    # if item.sell_in < 0
    #   if item.name != "Aged Brie"
    #     if item.name != "Backstage passes to a TAFKAL80ETC concert"
    #       if item.quality > 0
    #         if item.name != "Sulfuras, Hand of Ragnaros"
    #           item.quality = item.quality - 1
    #         end
    #       end
    #     else
    #       item.quality = item.quality - item.quality
    #     end
    #   else
    #     if item.quality < 50
    #       item.quality = item.quality + 1
    #     end
    #   end
    # end
  end

  def brie_quality(item)

  end

  def sulfuras_quality(item)

  end

  def backstage_quality(item)

  end

  # def conjured_quality(item)

  # end

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
    return if @quality.zero?

    @quality -= qty
  end

  def increase_quality(qty = 1)
    @quality += qty
  end

  def decrease_sell_in
    @sell_in -= 1
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
