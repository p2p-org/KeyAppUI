// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import UIKit

public extension IconButton {
    enum Style: CaseIterable {
        case primary
        case primaryWhite
        case second
        case third
        case ghostBlack
        case ghostWhite
        case ghostLime
        case inverted

        var backgroundColor: UIColor {
            switch self {
            case .primary, .primaryWhite: return Asset.Colors.night.color
            case .second: return Asset.Colors.rain.color
            case .third: return Asset.Colors.lime.color
            case .ghostBlack, .ghostWhite, .ghostLime: return .clear
            case .inverted: return Asset.Colors.snow.color
            }
        }

        var disabledBackgroundColor: UIColor? {
            Asset.Colors.rain.color
        }

        var iconColor: UIColor {
            switch self {
            case .primary, .ghostLime: return Asset.Colors.lime.color
            case .primaryWhite, .ghostWhite: return Asset.Colors.snow.color
            case .second, .third, .ghostBlack, .inverted: return Asset.Colors.night.color
            }
        }

        var titleColor: UIColor {
            switch self {
            case .primary, .primaryWhite, .second, .third, .ghostBlack, .inverted: return Asset.Colors.night.color
            case .ghostWhite: return Asset.Colors.snow.color
            case .ghostLime: return Asset.Colors.lime.color
            }
        }

        var disabledIconColor: UIColor? {
            Asset.Colors.mountain.color
        }

        func font(size: Size) -> UIFont {
            UIFont.font(of: .label2, weight: .regular)
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

        var width: CGFloat {
            switch self {
            case .small: return 36
            case .medium: return 52
            case .large: return 80
            }
        }

        var borderRadius: CGFloat {
            switch self {
            case .small: return 8
            case .medium: return 12
            case .large: return 20
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .small: return 12
            case .medium: return 20
            case .large: return 32
            }
        }

        var titleSpacing: CGFloat {
            switch self {
            case .small: return 4
            case .medium: return 4
            case .large: return 8
            }
        }
    }

    /// Create button with defined style
    static func style(image: UIImage, title: String? = nil, style: Style, size: Size) -> IconButton {
        let theme: IconButtonTheme = .init(
            iconColor: style.iconColor,
            titleColor: style.titleColor,
            backgroundColor: style.backgroundColor,
            font: style.font(size: size),
            iconSize: size.iconSize,
            titleSpacing: size.titleSpacing,
            borderRadius: size.borderRadius
        )

        return IconButton(
            image: image,
            title: title,
            themes: [
                .normal: theme,
                .disabled: theme.copy(
                    iconColor: style.disabledIconColor,
                    backgroundColor: style.disabledBackgroundColor
                ),
                .highlighted: theme.copy(backgroundColor: style.highlight),
            ]
        ).frame(width: size.width)
    }
}
