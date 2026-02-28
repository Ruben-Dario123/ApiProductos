defmodule HolaApi.TestDB do
  alias HolaApi.Repo

  def check do
    Repo.query!("SELECT 1")
    :db_conectada
  end
end
