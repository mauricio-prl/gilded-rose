defmodule GildedRose.Updater do
  @callback update(Item.t()) :: Item.t()

  def for("Aged Brie"), do: GildedRose.Updater.AgedBrie
  def for("Backstage passes to a TAFKAL80ETC concert"), do: GildedRose.Updater.Backstage
  def for("Sulfuras, Hand of Ragnaros"), do: GildedRose.Updater.Sulfuras
  def for("Conjured Mana Cake"), do: GildedRose.Updater.Conjured
  def for(_), do: GildedRose.Updater.Normal
end
