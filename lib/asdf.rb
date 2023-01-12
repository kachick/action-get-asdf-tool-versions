# frozen_string_literal: true

module Asdf
  # @param [String] body
  # @return [Hash<String, String>]
  def self.parse_primaries(body)
    body.each_line.each_with_object({}) do |line, outputs|
      comment_trimmed = line.slice(/[^#]+/)
      tool_name, primary_version, *_rest_versions = comment_trimmed.split
      if tool_name && primary_version
        outputs[tool_name] = primary_version
      end
    end
  end
end
