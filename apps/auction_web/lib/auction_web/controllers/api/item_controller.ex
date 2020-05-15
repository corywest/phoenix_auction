defmodule AuctionWeb.Api.ItemController do
  use AuctionWeb, :controller

  def index(conn, _params) do
    items = Auction.list_items()
    render(conn, "index.json", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item(id)
    render(conn, "show.json", item: item)
  end

  def show_item_with_bids(conn, %{"item_id" => item_id}) do
    item = Auction.get_item_with_bids(item_id)

    render(conn, "show_item_with_bids.json", item: item)
  end
end
