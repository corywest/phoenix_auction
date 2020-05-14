defmodule AuctionWeb.ItemView do
  use AuctionWeb, :view

  def item_open_for_auction?(item) do
    if item.ends_at > Time.utc_now do
      true
    else
      false
    end
  end
end
