// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation
import UIKit

/// A theme for ``IconButton``
public struct IconButtonTheme {
    let iconColor: UIColor
    let titleColor: UIColor
    let backgroundColor: UIColor
    let font: UIFont
    let iconSize: CGFloat
    let titleSpacing: CGFloat
    let borderRadius: CGFloat

    public init(
        iconColor: UIColor,
        titleColor: UIColor,
        backgroundColor: UIColor,
        font: UIFont,
        iconSize: CGFloat,
        titleSpacing: CGFloat,
        borderRadius: CGFloat
    ) {
        self.iconColor = iconColor
        self.titleColor = titleColor
        self.backgroundColor = backgroundColor
        self.font = font
        self.iconSize = iconSize
        self.titleSpacing = titleSpacing
        self.borderRadius = borderRadius
    }

    public static func `default`() -> Self {
        .init(
            iconColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
            titleColor: UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1),
            backgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            font: .systemFont(ofSize: 16, weight: .medium),
            iconSize: 40,
            titleSpacing: 8,
            borderRadius: 20
        )
    }

    func copy(
        iconColor: UIColor? = nil,
        backgroundColor: UIColor? = nil
    ) -> Self {
        .init(
            iconColor: iconColor ?? self.iconColor,
            titleColor: titleColor,
            backgroundColor: backgroundColor ?? self.backgroundColor,
            font: font,
            iconSize: iconSize,
            titleSpacing: titleSpacing,
            borderRadius: borderRadius
        )
    }
}
