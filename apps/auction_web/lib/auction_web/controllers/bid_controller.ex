defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    case Auction.create_bid(amount, item_id, user_id) do
      {:ok, bid} ->

        html =
          Phoenix.View.render_to_string(AuctionWeb.BidView,
                                        "bid.html",
                                        bid: bid,
                                        username: conn.assigns.current_user.username)

        AuctionWeb.Endpoint.broadcast("item:#{item_id}",
                                      "new_bid",
                                      %{body: html})

        redirect(conn, to: Routes.item_path(conn, :show, bid.item_id))

      {:error, bid} ->
        conn
        |> put_flash(:error, "Something went wrong. Please try again.")
        |> put_view(AuctionWeb.ItemView)
        |> render("show.html", bid: bid)

      {:error, item, bid} ->
        conn
        |> put_flash(:error, "Nice try, but you can't do that.")
        |> put_view(AuctionWeb.ItemView)
        |> render("show.html", item: item, bid: bid)
    end
  end
end
