require 'json'
require 'typhoeus'
require_relative 'lib/ac_object'

parsed = JSON.parse(Typhoeus.get("https://api.mercadolibre.com/items/MLB1578157865").body)
ac_object = AcObject.new(parsed)
a = AcObject.new({"inspect" => 4})
binding.irb