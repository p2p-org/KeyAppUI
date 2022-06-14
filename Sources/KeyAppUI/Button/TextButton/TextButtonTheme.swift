// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation
import UIKit

/// A theme for ``TextButton``
public struct TextButtonTheme {
    let backgroundColor: UIColor
    let foregroundColor: UIColor

    let font: UIFont

    let contentPadding: UIEdgeInsets
    let iconSpacing: CGFloat

    let borderRadius: CGFloat

    public init(
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        font: UIFont,
        contentPadding: UIEdgeInsets,
        iconSpacing: CGFloat,
        borderRadius: CGFloat
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
        self.contentPadding = contentPadding
        self.iconSpacing = iconSpacing
        self.borderRadius = borderRadius
    }

    public static func `default`() -> Self {
        .init(
            backgroundColor: Asset.Colors.night.color,
            foregroundColor: Asset.Colors.lime.color,
            font: .systemFont(ofSize: 16, weight: .medium),
            contentPadding: .init(top: 0, left: 28, bottom: 0, right: 20),
            iconSpacing: 12,
            borderRadius: 12
        )
    }

    func copy(
        backgroundColor: UIColor? = nil,
        foregroundColor: UIColor? = nil
    ) -> Self {
        .init(
            backgroundColor: backgroundColor ?? self.backgroundColor,
            foregroundColor: foregroundColor ?? self.foregroundColor,
            font: font,
            contentPadding: contentPadding,
            iconSpacing: iconSpacing,
            borderRadius: borderRadius
        )
    }
}
