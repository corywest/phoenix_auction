defmodule Auction.Item do
  defstruct [
    id: 1,
    title: "Default title",
    description: "An aunction item",
    ends_at: ~N[2020-12-21 23:59:59]
  ]
end
