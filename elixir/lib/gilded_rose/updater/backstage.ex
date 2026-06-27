defmodule GildedRose.Updater.Backstage do
  @behaviour GildedRose.Updater

  alias GildedRose.Updater.Common

  def update(item) do
    item = Common.dec_sell_in(item)

    item =
      cond do
        item.sell_in <= 0 -> Common.set_quality(item, 0)
        item.sell_in <= 5 -> Common.inc_quality(item, 3)
        item.sell_in <= 10 -> Common.inc_quality(item, 2)
        true -> Common.inc_quality(item, 1)
      end

    Common.clamp_quality(item)
  end
end
