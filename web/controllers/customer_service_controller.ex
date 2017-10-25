defmodule Takso.CustomerServiceController do
  use Takso.Web, :controller
  import Ecto.Query, only: [from: 2]
  alias Takso.{CSRequest, Trip}

  def lost_and_found(conn, params) do
    if (params != %{}) do
      %{"cs_request" => request} = params
      %{"date_of_trip" => date} = request
      query = from t in Trip, where: t.date == ^date
      trips = Repo.all(from t in query, select: t)
      changeset = CSRequest.changeset(%CSRequest{})
      render conn, "lost_and_found.html", changeset: changeset, trips: trips
      IO.inspect query 
    else 
    
      changeset = CSRequest.changeset(%CSRequest{})
      trips = []
      render conn, "lost_and_found.html", changeset: changeset, trips: trips
    end
  end
end
