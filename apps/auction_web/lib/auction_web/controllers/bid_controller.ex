defmodule AuctionWeb.BidController do
  use AuctionWeb, :controller
  plug :require_logged_in_user

  def create(conn, %{"bid" => %{"amount" => amount}, "item_id" => item_id}) do
    user_id = conn.assigns.current_user.id

    with true <- check_if_bid_is_higher_than_max(amount, item_id),
         {:ok, bid} <- Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
      redirect(conn, to: Routes.item_path(conn, :show, bid.item_id))
    else
      {:error, bid} ->
        item = Auction.get_item(item_id)
        render(conn, AuctionWeb.ItemView, "show.html", item: item, bid: bid)
    end

    # case Auction.insert_bid(%{amount: amount, item_id: item_id, user_id: user_id}) do
    #   {:ok, bid} ->
    #     redirect(conn, to: Routes.item_path(conn, :show, bid.item_id))
    #   {:error, bid} ->
    #     item = Auction.get_item(item_id)
    #     render(conn, AuctionWeb.ItemView, "show.html", item: item, bid: bid)
    # end
  end

  defp check_if_bid_is_higher_than_max(amount, item_id) do
    bid_max_amount =
      case Auction.get_highest_bid_for_item(item_id) do
        [current_max] -> current_max
        _ -> 0
      end

    if String.to_integer(amount) > bid_max_amount do
      true
    else
      false
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
