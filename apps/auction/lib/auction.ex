defmodule Auction do
  alias Auction.{FakeRepo, Item}

  @repo FakeRepo

  def list_items do
    @repo.all(Item)
  end

  def get_item(item_id) do
    @repo.get!(Item, item_id)
  end

  def get_item_by(attrs) do
    @repo.get_by(Item, attrs)
  end
end
