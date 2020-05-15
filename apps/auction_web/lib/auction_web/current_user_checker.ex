defmodule AuctionWeb.CurrentUserChecker do
  use AuctionWeb, :controller
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, %{"assigns" => %{current_user: nil}}) do
    conn
    |> put_flash(:error, "Nice try, but you need to be logged in to do that.")
    |> redirect(to: Routes.item_path(conn, :index))
  end

  def call(conn, _opts), do: conn
end
