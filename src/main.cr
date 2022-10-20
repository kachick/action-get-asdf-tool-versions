require "./jsonizer"

if ARGV.first == "jsonize"
  print Jsonizer.run(STDIN)
end
