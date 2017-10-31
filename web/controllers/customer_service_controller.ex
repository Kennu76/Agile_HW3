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

    # Check if params are there
    if ( params != %{} ) do
      # Do most of things here

      # Get arguments
      %{"cs_request" => request} = params
      %{"date_of_incident" => date} = request
      %{"taxi_id" => taxiId } = request
      %{"checkbox_25plus" => cBox25 } = request
      %{"checkbox_50plus" => cBox50 } = request
      %{"pickup_address" => pick_up_address } = request
      %{"dropoff_address" => drop_off_address } = request

      # Build query
      query = from u in Takso.Trip
      if date != "" do
        query = from u in query, where: u.date == ^date
      end
      if taxiId != "" do
        query = from u in query, where: u.taxi_id == ^taxiId
      end
      if pick_up_address != "" do
        query = from u in query, where: u.pickup_address == ^pick_up_address
      end
      if drop_off_address != "" do
        query = from u in query, where: u.dropoff_address == ^drop_off_address
      end
      query = from u in query, select: u

      # Query for trips
      trips = Repo.all(query)

      # Change changeset
      if Map.has_key?(params, "action") do
        changeset = CSRequest.changeset(%CSRequest{})
      else
        changeset = CSRequest.changeset(%CSRequest{},request)
      end

    # IF PARAMS EMPTY
    else
      trips = Repo.all(Takso.Trip)
      cBox25 = false;
      cBox50 = false;
    end
    # Render
    render conn, "scam_analysis.html", changeset: changeset, checkbox_25plus: cBox25, checkbox_50plus: cBox50, trips: trips
  end

end
