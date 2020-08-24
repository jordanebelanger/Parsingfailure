# Parsefail

When using https://github.com/skelpo/JSON to decode dynamic json of an unknown format, the json belows lead to a crash on the two most popular custom (non-foundation) json decoder in Swift.
```swift
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

// This won't be reached but IkigaJSON also crashes when dealing with this json and skelpo's JSON.
let ikigaJSON = try IkigaJSONDecoder().decode(JSON.self, from: data)
print("Ikiga decoded ok")
```
As the comments describe, the Foundation JSONDecoder can handle the JSON above when decoding it as a skelpo/JSON value but the others do not, seems to be related to `UnkeyedDecodingContainer`.
