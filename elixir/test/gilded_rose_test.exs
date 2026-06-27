defmodule GildedRoseTest do
  use ExUnit.Case, async: true

  # import ExUnit.CaptureIO

  # test "Approval test 30 days" do
  #   expected =
  #     File.read!("test/ApprovalTest.ThirtyDays.verified.txt") |> String.replace("\r\n", "\n")

  #   result =
  #     capture_io(fn -> GildedRose.TextTestFixture.run(30) end) |> String.replace("\r\n", "\n")

  #   assert result == expected
  # end

  test "normal items: decreases sell_in and quality" do
    item = update_item("foo", 10, 20)

    assert item.sell_in == 9
    assert item.quality == 19
  end

  test "normal items after sell date" do
    item = update_item("foo", 0, 20)

    assert item.sell_in == -1
    assert item.quality == 18
  end

  test "normal items when quality is already 0" do
    item = update_item("foo", 5, 0)

    assert item.sell_in == 4
    assert item.quality == 0
  end

  test "normal items when quality is 0 after sell date" do
    item = update_item("foo", 0, 0)

    assert item.sell_in == -1
    assert item.quality == 0
  end

  test "normal items keep name unchanged" do
    item = update_item("foo", 10, 20)

    assert item.sell_in == 9
    assert item.name == "foo"
  end

  test "Aged Brie increases in quality" do
    item = update_item("Aged Brie", 10, 20)

    assert item.sell_in == 9
    assert item.quality == 21
  end

  test "Aged Brie after sell date" do
    item = update_item("Aged Brie", 0, 20)

    assert item.sell_in == -1
    assert item.quality == 22
  end

  test "Aged Brie at max quality" do
    item = update_item("Aged Brie", 5, 50)

    assert item.sell_in == 4
    assert item.quality == 50
  end

  test "Sulfuras never changes" do
    item = update_item("Sulfuras, Hand of Ragnaros", 0, 80)

    assert item.sell_in == 0
    assert item.quality == 80
  end

  test "Backstage passes increase by 1 when sell_in > 10" do
    item = update_item("Backstage passes to a TAFKAL80ETC concert", 15, 20)

    assert item.sell_in == 14
    assert item.quality == 21
  end

  test "Backstage passes increase by 2 when sell_in is 10 days or less" do
    item = update_item("Backstage passes to a TAFKAL80ETC concert", 10, 20)

    assert item.sell_in == 9
    assert item.quality == 22
  end

  test "Backstage passes increase by 3 when sell_in is 5 days or less" do
    item = update_item("Backstage passes to a TAFKAL80ETC concert", 5, 20)

    assert item.sell_in == 4
    assert item.quality == 23
  end

  test "Backstage passes drop to 0 after the concert" do
    item = update_item("Backstage passes to a TAFKAL80ETC concert", 0, 20)

    assert item.sell_in == -1
    assert item.quality == 0
  end

  test "Backstage passes near max quality" do
    item = update_item("Backstage passes to a TAFKAL80ETC concert", 5, 49)

    assert item.sell_in == 4
    assert item.quality == 50
  end

  @tag skip: "Equivalent to xit in Ruby spec (pending Conjured quality behavior)"
  test "Conjured items degrade quality twice as fast" do
    item = update_item("Conjured Mana Cake", 10, 20)

    assert item.quality == 18
  end

  test "Conjured items still decrease sell_in" do
    item = update_item("Conjured Mana Cake", 10, 20)

    assert item.sell_in == 9
  end

  test "Conjured items after sell date still decrease sell_in" do
    item = update_item("Conjured Mana Cake", 0, 20)

    assert item.sell_in == -1
  end

  @tag skip: "Equivalent to xit in Ruby spec (pending Conjured quality behavior)"
  test "Conjured items after sell date degrade quality by 4" do
    item = update_item("Conjured Mana Cake", 0, 20)

    assert item.quality == 16
  end

  test "Conjured items near zero quality still decrease sell_in" do
    item = update_item("Conjured Mana Cake", 0, 3)

    assert item.sell_in == -1
  end

  @tag skip: "Equivalent to xit in Ruby spec (pending Conjured quality behavior)"
  test "Conjured items never go below zero quality" do
    item = update_item("Conjured Mana Cake", 0, 3)

    assert item.quality == 0
  end

  test "global quality rules: quality is never more than 50" do
    item = update_item("Aged Brie", 2, 50)

    assert item.sell_in == 1
    assert item.quality <= 50
  end

  test "global quality rules: Sulfuras is exempt" do
    item = update_item("Sulfuras, Hand of Ragnaros", 5, 80)

    assert item.sell_in == 5
    assert item.quality == 80
  end

  defp update_item(name, sell_in, quality) do
    [%Item{name: name, sell_in: sell_in, quality: quality}]
    |> GildedRose.update_quality()
    |> List.first()
  end
end
