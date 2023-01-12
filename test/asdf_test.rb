# frozen_string_literal: true

require 'test/unit'

require_relative '../lib/asdf'

class TestAsdf < Test::Unit::TestCase
  EXAMPLE =<<'EOD'
  shellcheck 0.9.0 0.7.2
  # This line and following line is comment

  nodejs 18.11.0 16.17.1 # This entry exists for test
  shfmt 3.6.0

  # versions might include non semver
  hugo extended_0.109.0 0.105.0
EOD

  def test_parse_primaries
    assert_equal({'nodejs'=>'18.11.0', 'shellcheck'=>'0.9.0', 'shfmt'=>'3.6.0', 'hugo'=>'extended_0.109.0'}, Asdf.parse_primaries(EXAMPLE))
    assert_equal({}, Asdf.parse_primaries('invalid'))
  end
end
