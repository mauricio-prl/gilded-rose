defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  defp update_item(item) do
    case item.name do
      "Aged Brie" -> update_brie_item(item)
      "Backstage passes to a TAFKAL80ETC concert" -> update_backstage_item(item)
      "Sulfuras, Hand of Ragnaros" -> update_sulfuras_item(item)
      "Conjured Mana Cake" -> update_conjured_item(item)
      _ -> update_normal_item(item)
    end
  end

  defp update_brie_item(item) do
    sell_in = item.sell_in - 1

    quality =
      cond do
        sell_in <= 0 -> item.quality + 2
        true -> item.quality + 1
      end

    build_item(item, sell_in, ensure_max_quality(quality))
  end

  defp update_backstage_item(item) do
    sell_in = item.sell_in - 1

    quality =
      cond do
        sell_in <= 0 -> 0
        sell_in <= 5 -> item.quality + 3
        sell_in <= 10 -> item.quality + 2
        true -> item.quality + 1
      end

    build_item(item, sell_in, ensure_max_quality(quality))
  end

  defp update_sulfuras_item(item), do: item

  defp update_conjured_item(item) do
    sell_in = item.sell_in - 1

    quality =
      cond do
        sell_in < 0 -> item.quality - 4
        true -> item.quality - 2
      end

    build_item(item, sell_in, ensure_no_negative(quality))
  end

  defp update_normal_item(item) do
    sell_in = item.sell_in - 1

    quality =
      cond do
        sell_in < 0 -> item.quality - 2
        true -> item.quality - 1
      end

    build_item(item, sell_in, ensure_no_negative(quality))
  end

  defp build_item(item, sell_in, quality), do: %{item | sell_in: sell_in, quality: quality}
  defp ensure_no_negative(quality), do: if(quality < 0, do: 0, else: quality)
  defp ensure_max_quality(quality), do: if(quality > 50, do: 50, else: quality)
end
