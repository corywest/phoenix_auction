defmodule Auction do
  alias Auction.{Item}

  alias Auction.Repo

  def list_items do
    Repo.all(Item)
  end

  def get_item(item_id) do
    Repo.get!(Item, item_id)
  end

  def get_item_by(attrs) do
    Repo.get_by(Item, attrs)
  end

  def insert_item(attrs) do
    Auction.Item
    |> struct(attrs)
    |> Repo.insert()
  end

  def update_item(%Auction.Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(%Auction.Item{} = item) do
    Repo.delete(item)
  end
end

# Public interface
