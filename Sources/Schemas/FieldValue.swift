import Foundation

public enum FieldValue: Codable, Hashable, Sendable {
    case dateTime(DateTime)
    case string(String)
    case double(Double)
    case long(Long)
    case range(Range)
    case boolean(Boolean)
    case entityId(EntityId)

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let discriminant = try container.decode(String.self, forKey: .type)
        switch discriminant {
        case "dateTime":
            self = .dateTime(try DateTime(from: decoder))
        case "string":
            self = .string(try String(from: decoder))
        case "double":
            self = .double(try Double(from: decoder))
        case "long":
            self = .long(try Long(from: decoder))
        case "range":
            self = .range(try Range(from: decoder))
        case "boolean":
            self = .boolean(try Boolean(from: decoder))
        case "entityId":
            self = .entityId(try EntityId(from: decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Unknown shape discriminant value: \(discriminant)"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws -> Void {
        switch self {
        case .dateTime(let data):
            try data.encode(to: encoder)
        case .string(let data):
            try data.encode(to: encoder)
        case .double(let data):
            try data.encode(to: encoder)
        case .long(let data):
            try data.encode(to: encoder)
        case .range(let data):
            try data.encode(to: encoder)
        case .boolean(let data):
            try data.encode(to: encoder)
        case .entityId(let data):
            try data.encode(to: encoder)
        }
    }

    public struct DateTime: Codable, Hashable, Sendable {
        public let type: String = "dateTime"
        public let value: Date
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: Date,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Date.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct String: Codable, Hashable, Sendable {
        public let type: String = "string"
        public let value: String
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: String,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(String.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct Double: Codable, Hashable, Sendable {
        public let type: String = "double"
        public let value: Double
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: Double,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Double.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct Long: Codable, Hashable, Sendable {
        public let type: String = "long"
        public let value: Int64
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: Int64,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Int64.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct Range: Codable, Hashable, Sendable {
        public let type: String = "range"
        /// Lower bound of the range (inclusive).
        public let from: Double?
        /// Upper bound of the range (exclusive).
        public let to: Double?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            from: Double? = nil,
            to: Double? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.from = from
            self.to = to
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.from = try container.decodeIfPresent(Double.self, forKey: .from)
            self.to = try container.decodeIfPresent(Double.self, forKey: .to)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encodeIfPresent(self.from, forKey: .from)
            try container.encodeIfPresent(self.to, forKey: .to)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case from
            case to
        }
    }

    public struct Boolean: Codable, Hashable, Sendable {
        public let type: String = "boolean"
        public let value: Bool
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            value: Bool,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.value = value
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.value = try container.decode(Bool.self, forKey: .value)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.value, forKey: .value)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case value
        }
    }

    public struct EntityId: Codable, Hashable, Sendable {
        public let type: String = "entityId"
        public let referenceId: String
        public let appId: String
        /// Human-readable name for the referenced entity (e.g., action name or document title).
        public let name: String?
        /// Additional properties that are not explicitly defined in the schema
        public let additionalProperties: [String: JSONValue]

        public init(
            referenceId: String,
            appId: String,
            name: String? = nil,
            additionalProperties: [String: JSONValue] = .init()
        ) {
            self.referenceId = referenceId
            self.appId = appId
            self.name = name
            self.additionalProperties = additionalProperties
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.referenceId = try container.decode(String.self, forKey: .referenceId)
            self.appId = try container.decode(String.self, forKey: .appId)
            self.name = try container.decodeIfPresent(String.self, forKey: .name)
            self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
        }

        public func encode(to encoder: Encoder) throws -> Void {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try encoder.encodeAdditionalProperties(self.additionalProperties)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.referenceId, forKey: .referenceId)
            try container.encode(self.appId, forKey: .appId)
            try container.encodeIfPresent(self.name, forKey: .name)
        }

        /// Keys for encoding/decoding struct properties.
        enum CodingKeys: String, CodingKey, CaseIterable {
            case type
            case referenceId
            case appId
            case name
        }
    }

    enum CodingKeys: String, CodingKey, CaseIterable {
        case type
    }
}