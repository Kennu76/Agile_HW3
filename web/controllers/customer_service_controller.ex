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
        if address == "" do
          query = Takso.Trip
        else
        end
      else
        date = date |> Timex.parse!("%Y-%m-%d", :strftime) |> Ecto.Date.cast!
        #IO.inspect(date)
        if address == "" do
          query = from t in Takso.Trip, where: t.date == ^date, select: t
          #IO.inspect query
        else
          query = from t in Takso.Trip, where: t.date == ^date and t.pickup_address == ^address, select: t
          #IO.inspect query
        end
      end
      #IO.inspect query
      trips = Repo.all(query)
      changeset = CSRequest.changeset(%CSRequest{},request)
    else
      #IO.inspect Takso.Trip
      trips = Repo.all(Takso.Trip)
    end
    render conn, "lost_and_found.html", changeset: changeset, trips: trips
  end


  def scam_analysis(conn, params) do
    changeset = CSRequest.changeset(%CSRequest{})
    render conn, "scam_analysis.html", changeset: changeset
  end
end
