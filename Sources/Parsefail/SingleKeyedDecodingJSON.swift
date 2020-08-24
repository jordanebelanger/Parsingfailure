/// A dynamic json object type similar to skelpo/JSON except we implement decoding using only a `SingleValueContainer` and recursion instead of using
/// a dynamic `CodingKey`.
public enum SingleKeyedDecodingJSON: Codable {
    case null
    case bool(Bool)
    case number(Number)
    case string(String)
    case array([SingleKeyedDecodingJSON])
    case object([String: SingleKeyedDecodingJSON])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
                
        if container.decodeNil() {
            self = .null
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode(Number.self) {
            self = .number(value)
        } else if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode([SingleKeyedDecodingJSON].self) {
            self = .array(value)
        } else if let value = try? container.decode([String: SingleKeyedDecodingJSON].self) {
            self = .object(value)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "JSON value cannot be decoded")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .null:
            try container.encodeNil()
        case .bool(let value):
            try container.encode(value)
        case .number(let value):
            try container.encode(value)
        case .string(let value):
            try container.encode(value)
        case .array(let value):
            try container.encode(value)
        case .object(let value):
            try container.encode(value)
        }
    }
}

extension SingleKeyedDecodingJSON {
    /// A wrapper for standard numeric types.
    public enum Number: Codable, Hashable, CustomStringConvertible {
        case int(Int)
        case double(Double)
        
        /// See `Decodable.init(from:)`.
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let int = try? container.decode(Int.self) {
                self = .int(int)
            } else if let double = try? container.decode(Double.self) {
                self = .double(double)
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "No number type found")
            }
        }
        
        /// See `Encodable.encode(to:)`.
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case let .int(int): try container.encode(int)
            case let .double(double): try container.encode(double)
            }
        }
        
        /// See `CustomStringConvertible.description`.
        public var description: String {
            switch self {
            case let .int(int): return String(describing: int)
            case let .double(double): return String(describing: double)
            }
        }
    }
}


extension SingleKeyedDecodingJSON.Number: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = .int(value)
    }
}

extension SingleKeyedDecodingJSON.Number: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = .double(value)
    }
}

