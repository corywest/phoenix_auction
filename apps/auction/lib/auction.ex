defmodule Auction do
  alias Auction.{Repo, Item, User, Password, Bid}

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
    %Item{}
    |> Item.changeset(attrs)
    |> Repo.insert()
  end

  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  def delete_item(%Item{} = item) do
    Repo.delete(item)
  end

  def new_item(), do: Item.changeset(%Item{})

  def edit_item(id) do
    get_item(id) |> Item.changeset()
  end

  def get_user(id), do: Repo.get!(User, id)

  def get_user_by_username_and_password(username, password) do
    with user when not is_nil(user) <- Repo.get_by(User, %{username: username}),
         true <- Password.verify_with_hash(password, user.hashed_password) do
      user

    else
      _ -> Password.dummy_verify
    end
  end

  def new_user(), do: User.changeset_with_password(%User{})

  def insert_user(params) do
    %User{}
    |> User.changeset_with_password(params)
    |> Repo.insert()
  end

  def new_bid(), do: Bid.changeset(%Bid{})

  def insert_bid(params) do
    %Bid{}
    |> Bid.changeset(params)
    |> Repo.insert()
  end
end
