require 'test_helper'

class Jekyll::Theme::AssetsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jekyll::Theme::Assets::VERSION
  end
end