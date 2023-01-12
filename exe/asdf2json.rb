# frozen_string_literal: true

require 'json'
require_relative '../lib/asdf'

puts Asdf.parse_primaries(STDIN.read).to_json
