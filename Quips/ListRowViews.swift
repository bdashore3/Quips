//
//  ListRowViews.swift
//  Quips
//
//  Created by Brian Dashore on 6/20/22.
//

import SwiftUI

import SwiftUI

// These views were imported from Asobi

// View alias for a list row with an external link
struct ListRowLinkView: View {
    let text: String
    let link: String

    var body: some View {
        HStack {
            Link(text, destination: URL(string: link)!)
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "arrow.up.forward.app.fill")
                .foregroundColor(.gray)
        }
    }
}

struct ListRowTextView: View {
    let leftText: String
    var rightText: String?
    var rightSymbol: String?

    var body: some View {
        HStack {
            Text(leftText)

            Spacer()

            if let rightText = rightText {
                Text(rightText)
            } else {
                Image(systemName: rightSymbol!)
                    .foregroundColor(.gray)
            }
        }
    }
}
