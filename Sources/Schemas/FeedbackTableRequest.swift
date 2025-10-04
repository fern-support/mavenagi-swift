import Foundation

public struct FeedbackTableRequest: Codable, Hashable, Sendable {
    /// Optional filter applied to refine the feedback data before processing.
    public let feedbackFilter: FeedbackFilter?
    /// IANA timezone identifier (e.g., "America/Los_Angeles").
    /// When provided, time-based groupings (e.g., DAY) and date filters are evaluated in this timezone;
    /// otherwise UTC is used.
    public let timezone: String?
    /// Defines the time interval for grouping data. If specified, data is grouped accordingly based on the time they were created.
    ///  Example: If set to "DAY," data will be aggregated by day.
    public let timeGrouping: TimeInterval?
    /// Specifies the fields by which data should be grouped. Each unique combination forms a row. 
    /// If multiple fields are provided, the result is grouped by their unique value combinations. 
    /// If empty, all data is aggregated into a single row. 
    /// Note: The field CreatedAt should not be used here, all the time-based grouping should be done using the timeGrouping field.
    public let fieldGroupings: [FeedbackGroupBy]
    /// Specifies the metrics to be displayed as columns.
    /// Column headers act as keys, with computed metric values as their mapped values.
    /// There needs to be at least one column definition in the table request.
    public let columnDefinitions: [FeedbackColumnDefinition]
    /// Additional properties that are not explicitly defined in the schema
    public let additionalProperties: [String: JSONValue]

    public init(
        feedbackFilter: FeedbackFilter? = nil,
        timezone: String? = nil,
        timeGrouping: TimeInterval? = nil,
        fieldGroupings: [FeedbackGroupBy],
        columnDefinitions: [FeedbackColumnDefinition],
        additionalProperties: [String: JSONValue] = .init()
    ) {
        self.feedbackFilter = feedbackFilter
        self.timezone = timezone
        self.timeGrouping = timeGrouping
        self.fieldGroupings = fieldGroupings
        self.columnDefinitions = columnDefinitions
        self.additionalProperties = additionalProperties
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.feedbackFilter = try container.decodeIfPresent(FeedbackFilter.self, forKey: .feedbackFilter)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
        self.timeGrouping = try container.decodeIfPresent(TimeInterval.self, forKey: .timeGrouping)
        self.fieldGroupings = try container.decode([FeedbackGroupBy].self, forKey: .fieldGroupings)
        self.columnDefinitions = try container.decode([FeedbackColumnDefinition].self, forKey: .columnDefinitions)
        self.additionalProperties = try decoder.decodeAdditionalProperties(using: CodingKeys.self)
    }

    public func encode(to encoder: Encoder) throws -> Void {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encodeAdditionalProperties(self.additionalProperties)
        try container.encodeIfPresent(self.feedbackFilter, forKey: .feedbackFilter)
        try container.encodeIfPresent(self.timezone, forKey: .timezone)
        try container.encodeIfPresent(self.timeGrouping, forKey: .timeGrouping)
        try container.encode(self.fieldGroupings, forKey: .fieldGroupings)
        try container.encode(self.columnDefinitions, forKey: .columnDefinitions)
    }

    /// Keys for encoding/decoding struct properties.
    enum CodingKeys: String, CodingKey, CaseIterable {
        case feedbackFilter
        case timezone
        case timeGrouping
        case fieldGroupings
        case columnDefinitions
    }
}