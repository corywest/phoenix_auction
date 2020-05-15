defmodule Auction.Repo.Migrations.AddDefaultValueForBid do
  use Ecto.Migration

  def change do
    alter table(:bids) do
      modify :amount, :integer, default: 0
    end
  end
end
