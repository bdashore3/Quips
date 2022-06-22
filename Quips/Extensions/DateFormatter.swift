//
//  DateFormatter.swift
//  Quips
//
//  Created by Brian Dashore on 6/20/22.
//

import Foundation

extension DateFormatter {
    static let quipDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.locale = Locale.current

        return df
    }()
}
