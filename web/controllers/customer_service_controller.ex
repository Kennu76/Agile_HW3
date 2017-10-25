defmodule Takso.CustomerServiceController do
  use Takso.Web, :controller

  alias Takso.CSRequest

  def lost_and_found(conn, _params) do
    changeset = CSRequest.changeset(%CSRequest{})
    trips = []
    render conn, "lost_and_found.html", changeset: changeset, trips: trips
  end
end
