# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Takso.Repo.insert!(%Takso.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.


Takso.Repo.insert!(%Takso.Trip{
    date: ~D[2000-01-01],
    pickup_address: "Kalevi",
    dropoff_address: "Mihkli",
    pickup_time: ~T[23:00:07.001],
    dropoff_time: ~T[23:00:07.001],
    est_pickup_time: ~T[23:00:07.001],
    est_duration: ~T[00:00:07.001],
    taxi_id: 1
})

Takso.Repo.insert!(%Takso.Trip{
    date: ~D[2000-08-01],
    pickup_address: "Kalevis",
    dropoff_address: "Mihklis",
    pickup_time: ~T[23:00:07.001],
    dropoff_time: ~T[23:00:07.001],
    est_pickup_time: ~T[23:00:07.001],
    est_duration: ~T[00:00:07.001],
    taxi_id: 1
})

Takso.Repo.insert!(%Takso.Trip{
    date: ~D[2000-08-01],
    pickup_address: "Naituse",
    dropoff_address: "Klebo",
    pickup_time: ~T[23:00:07.001],
    dropoff_time: ~T[23:00:07.001],
    est_pickup_time: ~T[23:00:07.001],
    est_duration: ~T[00:00:07.001],
    taxi_id: 1
})
