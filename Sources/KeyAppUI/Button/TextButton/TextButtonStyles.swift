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
            case .primary, .primaryWhite: return Asset.Colors.night.color
            case .second: return Asset.Colors.rain.color
            case .third: return Asset.Colors.lime.color
            case .ghost, .ghostWhite, .ghostLime: return .clear
            case .inverted, .invertedRed: return Asset.Colors.snow.color
            }
        }

        var disabledBackgroundColor: UIColor? {
            Asset.Colors.rain.color
        }

        var foreground: UIColor {
            switch self {
            case .primary, .ghostLime: return Asset.Colors.lime.color
            case .primaryWhite, .ghostWhite: return Asset.Colors.snow.color
            case .second, .third, .ghost, .inverted: return Asset.Colors.night.color
            case .invertedRed: return Asset.Colors.rose.color
            }
        }

        var disabledForegroundColor: UIColor? {
            Asset.Colors.mountain.color
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

        var loadingBackgroundColor: UIColor {
            switch self {
            case .primary, .primaryWhite, .ghostWhite, .ghostLime: return Asset.Colors.snow.color.withAlphaComponent(0.6)
            case .invertedRed: return Asset.Colors.rain.color
            default: return Asset.Colors.night.color.withAlphaComponent(0.6)
            }
        }

        var loadingForegroundColor: UIColor {
            switch self {
            case .primary, .ghostLime: return Asset.Colors.lime.color
            case .primaryWhite, .ghostWhite: return Asset.Colors.snow.color
            case .second, .third, .ghost, .inverted: return Asset.Colors.night.color
            case .invertedRed: return Asset.Colors.rose.color
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
            borderRadius: size.borderRadius,
            loadingBackgroundColor: style.loadingBackgroundColor,
            loadingForegroundColor: style.loadingForegroundColor
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
