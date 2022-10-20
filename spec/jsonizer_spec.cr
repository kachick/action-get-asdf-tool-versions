require "./spec_helper"

require "../src/jsonizer"

require "json"

describe Jsonizer do
  describe ".run" do
    it "returns serialized JSON" do
      io = IO::Memory.new(
        <<-TEXT
        shellcheck 0.8.0 0.7.2
        nodejs 18.11.0 16.17.1
        shfmt 3.5.1
        crystal 1.6.0
        TEXT
      )
      Jsonizer::ParsedJson.from_json(Jsonizer.run(io)).should eq(
        {"shellcheck" => "0.8.0", "nodejs" => "18.11.0", "shfmt" => "3.5.1", "crystal" => "1.6.0"}
      )
    end
  end
end
