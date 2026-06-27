defmodule GildedRose.Updater.Conjured do
  @behaviour GildedRose.Updater

  alias GildedRose.Updater.Common

  def update(item) do
    item = Common.dec_sell_in(item)

    item =
      if item.sell_in < 0 do
        Common.dec_quality(item, 4)
      else
        Common.dec_quality(item, 2)
      end

    Common.clamp_quality(item)
  end
end
