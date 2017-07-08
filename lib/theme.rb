# Lets extend base class with a few things to make our code
# less confusing (I hope that is the case LOL).
class Jekyll::Theme
  # Our theme's public assets.
  alias_method :public_assets_path, :assets_path

  # Our theme's private assets.
  def private_assets_path
    path_for "_assets".freeze
  end
end