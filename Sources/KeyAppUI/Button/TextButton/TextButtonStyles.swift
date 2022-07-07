// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import UIKit

public extension TextButton {
    enum Style: CaseIterable {
        case primary
        case primaryWhite
        case second
        case third
        case ghost
        case ghostWhite
        case ghostLime
        case inverted
        case invertedRed

        var backgroundColor: UIColor {
            switch self {
            case .primary, .primaryWhite: return .night
            case .second: return .rain
            case .third: return .lime
            case .ghost, .ghostWhite, .ghostLime: return .clear
            case .inverted, .invertedRed: return .snow
            }
        }

        var disabledBackgroundColor: UIColor? {
            .rain
        }

        var foreground: UIColor {
            switch self {
            case .primary, .ghostLime: return .lime
            case .primaryWhite, .ghostWhite: return .snow
            case .second, .third, .ghost, .inverted: return .night
            case .invertedRed: return .rose
            }
        }

        var disabledForegroundColor: UIColor? {
            .mountain
        }

        func font(size: Size) -> UIFont {
            switch size {
            case .large, .medium: return UIFont.font(of: .text2, weight: .bold)
            case .small: return UIFont.font(of: .text4, weight: .bold)
            }
        }

        var highlight: UIColor {
            switch self {
            default: return .gray
            }
        }
    }

    enum Size: CaseIterable {
        case large
        case medium
        case small

        var height: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 48
            case .large: return 56
            }
        }

        var borderRadius: CGFloat {
            switch self {
            case .small: return 8
            case .medium: return 12
            case .large: return 12
            }
        }
    }

    /// Create button with defined style
    convenience init(title: String, style: Style, size: Size, leading: UIImage? = nil, trailing: UIImage? = nil) {
        let theme = TextButtonAppearance(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.foreground,
            font: style.font(size: size),
            contentPadding: .init(
                top: 0,
                left: leading != nil ? 14 : 20,
                bottom: 0,
                right: trailing != nil ? 14 : 20
            ),
            iconSpacing: 8,
            borderRadius: size.borderRadius
        )
        self.init(
            leadingImage: leading,
            title: title,
            trailingImage: trailing,
            themes: [
                .normal: theme,
                .disabled: theme.copy(
                    backgroundColor: style.disabledBackgroundColor,
                    foregroundColor: style.disabledForegroundColor
                ),
                .highlighted: theme.copy(backgroundColor: style.highlight),
            ]
        )
        _ = frame(height: size.height)
    }
}
