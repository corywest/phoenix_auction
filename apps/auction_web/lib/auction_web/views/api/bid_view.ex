defmodule AuctionWeb.Api.BidView do
  use AuctionWeb, :view

  def render("bid.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount
    }
  end
end
