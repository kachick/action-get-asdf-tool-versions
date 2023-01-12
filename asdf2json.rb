require 'json'

puts(
  STDIN.each_line.each_with_object({}) do |line, outputs|
  comment_trimmed = line.slice(/[^#]+/)
  tool_name, primary_version, *_rest_versions = comment_trimmed.split
  outputs[tool_name] = primary_version
  end.to_json
)

