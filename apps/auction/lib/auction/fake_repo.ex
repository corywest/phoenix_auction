defmodule Auction.FakeRepo do
  alias Auction.Item

  @items [
    %Item{
      id: 1,
      title: "My first item",
      description: "A good first description",
      ends_at: ~N[2020-12-31 23:59:59]
    },
    %Item{
      id: 2,
      title: "A second item",
      description: "Another good description",
      ends_at: ~N[2020-05-31 23:59:59]
    },
    %Item{
      id: 3,
      title: "Third item",
      description: "Third description",
      ends_at: ~N[2020-12-31 23:59:59]
    }
  ]

  def all(Item), do: @items

  def get!(Item, item_id) do
    Enum.find @items,
      (fn item -> item.id == item_id end)
  end

  def get_by(Item, attrs) do
    Enum.find(@items, fn(item) ->
      Enum.all?(Map.keys(attrs), fn key ->
        Map.get(item, key) == attrs[key]
      end)
    end)
  end
end
