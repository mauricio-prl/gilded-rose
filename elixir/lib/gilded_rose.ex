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
      _ -> update_normal_item(item)
    end

    # item =
    #   cond do
    #     item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #       if item.quality > 0 do
    #         if item.name != "Sulfuras, Hand of Ragnaros" do
    #           %{item | quality: item.quality - 1}
    #         else
    #           item
    #         end
    #       else
    #         item
    #       end

    #     true ->
    #       cond do
    #         item.quality < 50 ->
    #           item = %{item | quality: item.quality + 1}

    #           cond do
    #             item.name == "Backstage passes to a TAFKAL80ETC concert" ->
    #               item =
    #                 cond do
    #                   item.sell_in < 11 ->
    #                     cond do
    #                       item.quality < 50 ->
    #                         %{item | quality: item.quality + 1}

    #                       true ->
    #                         item
    #                     end

    #                   true ->
    #                     item
    #                 end

    #               cond do
    #                 item.sell_in < 6 ->
    #                   cond do
    #                     item.quality < 50 ->
    #                       %{item | quality: item.quality + 1}

    #                     true ->
    #                       item
    #                   end

    #                 true ->
    #                   item
    #               end

    #             true ->
    #               item
    #           end

    #         true ->
    #           item
    #       end
    #   end

    # item =
    #   cond do
    #     item.name != "Sulfuras, Hand of Ragnaros" ->
    #       %{item | sell_in: item.sell_in - 1}

    #     true ->
    #       item
    #   end

    # cond do
    #   item.sell_in < 0 ->
    #     cond do
    #       item.name != "Aged Brie" ->
    #         cond do
    #           item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #             cond do
    #               item.quality > 0 ->
    #                 cond do
    #                   item.name != "Sulfuras, Hand of Ragnaros" ->
    #                     %{item | quality: item.quality - 1}

    #                   true ->
    #                     item
    #                 end

    #               true ->
    #                 item
    #             end

    #           true ->
    #             %{item | quality: item.quality - item.quality}
    #         end

    #       true ->
    #         cond do
    #           item.quality < 50 ->
    #             %{item | quality: item.quality + 1}

    #           true ->
    #             item
    #         end
    #     end

    #   true ->
    #     item
    # end
  end

  defp update_backstage_item(item) do
  end

  defp update_brie_item(item) do
  end

  defp update_sulfuras_item(item) do
  end

  defp update_normal_item(item) do
    sell_in = item.sell_in - 1

    quality =
      cond do
        sell_in < 0 -> item.quality - 2
        true -> item.quality - 1
      end

    %{item | sell_in: sell_in, quality: ensure_no_negative(quality)}
  end

  defp ensure_no_negative(quality), do: if(quality < 0, do: 0, else: quality)
end
