defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller
  plug :require_current_user when action in [:new, :create]

  def index(conn, _params) do
    items = Auction.list_items()

    render(conn, "index.html", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item_with_bids(id)
    bid = Auction.new_bid()

    render(conn, "show.html", item: item, bid: bid)
  end

  def new(conn, _params) do
    item = Auction.new_item()
    render(conn, "new.html", item: item)
  end

  def create(conn, %{"item" => item_params}) do
    user_id = conn.assigns.current_user.id

    case Auction.insert_item(user_id, item_params) do
      {:ok, item} ->
        redirect(conn, to: Routes.item_path(conn, :show, item))

      {:error, item} ->
        render(conn, "new.html", item: item)
    end
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.edit_item(id)
    render(conn, "edit.html", item: item)
  end

  def update(conn, %{"id" => id, "item" => item_params}) do
    item = Auction.get_item(id)
    case Auction.update_item(item, item_params) do
      {:ok, item} ->
        render(conn, "show.html", item: item)
      {:error, item} ->
        redirect(conn, to: Routes.item_path(conn, :edit, item))
    end
  end

  defp require_current_user(conn, %{"assigns" => %{current_user: nil}}) do
    conn
    |> put_flash(:error, "Nice try, but you need to be logged in to do that.")
    |> redirect(to: Routes.item_path(conn, :index))
    |> halt()
  end

  defp require_current_user(conn, _opts), do: conn
end
