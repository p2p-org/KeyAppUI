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
            case .primary: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .primaryWhite: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .second: return UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1)
            case .third: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            case .ghostBlack, .ghostWhite, .ghostLime: return .clear
            case .inverted: return .white
            }
        }

        var disabledBackgroundColor: UIColor? {
            UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1)
        }

        var iconColor: UIColor {
            switch self {
            case .primary, .ghostLime: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            case .primaryWhite, .ghostWhite: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .second, .third, .ghostBlack, .inverted: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            }
        }

        var titleColor: UIColor {
            switch self {
            case .primary, .primaryWhite, .second, .third, .ghostBlack, .inverted: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .ghostWhite: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .ghostLime: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            }
        }

        var disabledIconColor: UIColor? {
            UIColor(red: 0.435, green: 0.49, blue: 0.553, alpha: 1)
        }

        var font: UIFont {
            switch self {
            default: return .systemFont(ofSize: 11, weight: .regular)
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

        var fontSize: CGFloat {
            switch self {
            case .small: return 13
            case .medium: return 16
            case .large: return 16
            }
        }

        var iconSize: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 28
            case .large: return 40
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
            font: style.font.withSize(size.fontSize),
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
