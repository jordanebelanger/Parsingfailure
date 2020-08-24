import Foundation
import PureSwiftJSON
import JSON
import IkigaJSON

let data = #"""
{
  "test": [
    {
      "k": 1
    }
  ]
}
"""#.data(using: .utf8)!

// Foundation can do it (on mac havent tested linux)
let foundationJSON = try JSONDecoder().decode(JSON.self, from: data)
print("Foundation decoded ok")

// For some reason this CRASHES :( (on mac haven't tested linux)
let pureSwiftJSON = try PSJSONDecoder().decode(JSON.self, from: data)
print("Pure swift decoded ok")

// This won't be reached but IkigaJSON also crashes when dealing with this.
let ikigaJSON = try IkigaJSONDecoder().decode(JSON.self, from: data)
print("Ikiga decoded ok")

// For some reason, we don't run into any issue when using a dynamic json object decoded using a single value container only
// like the anycodable library is doing. See https://github.com/Flight-School/AnyCodable, the `SingleKeyedDecodingJSON`
// enum uses the same strategy for decoding as whats done in this particular library.
let pureSwiftJSONSingleKeyContainerDecoding = try PSJSONDecoder().decode(SingleKeyedDecodingJSON.self, from: data)
print("Pure swift decoded dynamic json ok when using a singleValueContainer dynamic json decoding strategy")
