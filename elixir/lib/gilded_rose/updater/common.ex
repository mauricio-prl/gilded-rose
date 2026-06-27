defmodule GildedRose.Updater.Common do
  def dec_sell_in(item), do: %{item | sell_in: item.sell_in - 1}
  def inc_quality(item, amount \\ 1), do: %{item | quality: item.quality + amount}
  def dec_quality(item, amount \\ 1), do: %{item | quality: item.quality - amount}
  def clamp_quality(item), do: %{item | quality: clamp(item.quality)}
  def set_quality(item, quality), do: %{item | quality: quality}

  defp clamp(quality) when quality < 0, do: 0
  defp clamp(quality) when quality > 50, do: 50
  defp clamp(quality), do: quality
end
