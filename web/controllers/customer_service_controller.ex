defmodule Takso.CustomerServiceController do
  use Takso.Web, :controller
  use Ecto.Schema
  import Ecto.Query

  alias Takso.CSRequest

  def lost_and_found(conn, params) do
    changeset = CSRequest.changeset(%CSRequest{})
    if ( params != %{} ) do
      %{"cs_request" => request} = params
      %{"date_of_trip" => date} = request
      %{"pickup_address" => address } = request
      if date == "" do
        query = from t in Takso.Trip, where: t.pickup_address == ^address, select: t
      else
        date = date |> Timex.parse!("%Y-%m-%d", :strftime) |> Ecto.Date.cast!
        #IO.inspect(date)
        if address == "" do
          query = from t in Takso.Trip, where: t.date == ^date, select: t
        else
          query = from t in Takso.Trip, where: t.date == ^date, where: t.pickup_address == ^address, select: t
        end
      end
      trips = Repo.all(query)
    else
      trips = Repo.all(Takso.Trip)
    end
    render conn, "lost_and_found.html", changeset: changeset, trips: trips
  end
end
