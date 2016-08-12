defmodule CodeCorps.UserView do
  use CodeCorps.Web, :view
  use JaSerializer.PhoenixView

  attributes [:username, :email, :inserted_at, :updated_at]

  has_one :slugged_route, serializer: CodeCorps.SluggedRouteView
end