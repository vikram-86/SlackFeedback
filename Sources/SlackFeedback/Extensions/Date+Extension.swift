import Foundation

internal extension Date {
    /// Formats the date instance into a string representation using a Norwegian locale and a specific date-time format.
    ///
    /// This method creates a `DateFormatter` configured with the "nb_NO" locale and the date-time format
    /// `"MM/dd/yyyy HH:mm"`. It then converts the `Date` instance into a string using the specified format.
    ///
    /// - Returns: A `String` representing the formatted date and time.
    func formattedDateString() -> String {
        // Create and configure the date formatter.
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "nb_NO")
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"

        // Convert the date to the formatted string and return it.
        return dateFormatter.string(from: self)
    }
}
