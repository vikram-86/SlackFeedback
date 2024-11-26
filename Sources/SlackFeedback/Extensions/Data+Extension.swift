import Foundation

extension Data {
    /// A computed property that returns a pretty-printed JSON string representation of the data, if valid.
    ///
    /// This property attempts to deserialize the `Data` instance as JSON and then serialize it back into a
    /// formatted (pretty-printed) JSON string. It can be useful for debugging purposes or displaying JSON data
    /// in a human-readable format.
    ///
    /// - Returns: A `String` containing the formatted JSON, or `nil` if the data is not valid JSON.
    var prettyPrintedJSONString: String? {
        // Try to deserialize the data into a JSON object.
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              // Try to serialize the JSON object back into data with pretty-printed formatting.
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              // Convert the data into a UTF-8 encoded string.
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
            return nil
        }
        return prettyPrintedString
    }
}
