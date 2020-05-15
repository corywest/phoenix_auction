defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    case Auction.create_bid(amount, item_id, user_id) do
      {:ok, bid} ->
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

  defp require_logged_in_user(conn, %{"assigns" => %{current_user: nil}}) do
    conn
    |> put_flash(:error, "Nice try, but you need to be logged in to do that.")
    |> redirect(to: Routes.item_path(conn, :index))
    |> halt()
  end

  defp require_logged_in_user(conn, _opts), do: conn
end
