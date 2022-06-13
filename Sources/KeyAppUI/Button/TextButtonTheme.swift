// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation
import UIKit

public enum TextButtonThemeState {
    case normal
    case disabled
}

public struct TextButtonTheme {
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let highlightColor: UIColor

    let font: UIFont

    let contentPadding: UIEdgeInsets
    let iconSpacing: CGFloat

    let borderRadius: CGFloat
    let minHeight: CGFloat

    public init(
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        highlightColor: UIColor,
        font: UIFont,
        contentPadding: UIEdgeInsets,
        iconSpacing: CGFloat,
        borderRadius: CGFloat,
        minHeight: CGFloat
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.highlightColor = highlightColor
        self.font = font
        self.contentPadding = contentPadding
        self.iconSpacing = iconSpacing
        self.borderRadius = borderRadius
        self.minHeight = minHeight
    }

    public static func primary() -> TextButtonTheme {
        .init(
            backgroundColor: UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1),
            foregroundColor: UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1),
            highlightColor: .gray,
            font: .systemFont(ofSize: 16, weight: .medium),
            contentPadding: .init(top: 0, left: 28, bottom: 0, right: 20),
            iconSpacing: 12,
            borderRadius: 12,
            minHeight: 56
        )
    }
}
