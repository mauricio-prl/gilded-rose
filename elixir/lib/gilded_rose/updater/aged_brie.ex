defmodule GildedRose.Updater.AgedBrie do
  @behaviour GildedRose.Updater

  alias GildedRose.Updater.Common

  def update(item) do
    item = Common.dec_sell_in(item)

    item =
      if item.sell_in <= 0 do
        Common.inc_quality(item, 2)
      else
        Common.inc_quality(item, 1)
      end

    Common.clamp_quality(item)
  end
end
