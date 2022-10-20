require "json"

module Jsonizer
  alias PluginName = String
  alias PluginVersion = String
  alias ParsedJson = Hash(PluginName, PluginVersion)

  def self.run(io : IO) : String
    io.each_line.to_h { |line| Tuple(String, String).from(line.split[0, 2]) }.to_json
  end
end
