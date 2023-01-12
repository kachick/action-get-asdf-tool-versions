# frozen_string_literal: true

module Asdf
  # @param [String] body
  # @return [Hash<String, String>]
  def self.parse_primaries(body)
    body.each_line.map do |line|
      comment_trimmed = line.slice(/[^#]+/)
      tool_name, primary_version, *_rest_versions = comment_trimmed.split
      (tool_name && primary_version) && [tool_name, primary_version]
    end.compact.to_h
  end
end
