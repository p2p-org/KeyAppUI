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
            case .primary: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .primaryWhite: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .second: return UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1)
            case .third: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            case .ghost, .ghostWhite, .ghostLime: return .clear
            case .inverted, .invertedRed: return .white
            }
        }

        var disabledBackgroundColor: UIColor? {
            UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1)
        }

        var foreground: UIColor {
            switch self {
            case .primary, .ghostLime: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            case .primaryWhite, .ghostWhite: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .second, .third, .ghost, .inverted: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .invertedRed: return UIColor(red: 0.922, green: 0.29, blue: 0.478, alpha: 1)
            }
        }

        var disabledForegroundColor: UIColor? {
            UIColor(red: 0.435, green: 0.49, blue: 0.553, alpha: 1)
        }

        var font: UIFont {
            switch self {
            default: return .systemFont(ofSize: 16, weight: .medium)
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

        var fontSize: CGFloat {
            switch self {
            case .small: return 13
            case .medium: return 16
            case .large: return 16
            }
        }
    }

    static func style(title: String, style: Style, size: Size, leading: UIImage? = nil, trailing: UIImage? = nil) -> TextButton {
        let theme = TextButtonTheme(
            backgroundColor: style.backgroundColor,
            foregroundColor: style.foreground,
            highlightColor: style.highlight,
            font: style.font.withSize(size.fontSize),
            contentPadding: .init(
                top: 0,
                left: leading != nil ? 14 : 20,
                bottom: 0,
                right: trailing != nil ? 14 : 20
            ),
            iconSpacing: 8,
            borderRadius: size.borderRadius
        )

        return TextButton(
            leadingImage: leading,
            title: title,
            trailingImage: trailing,
            themes: [
                .normal: theme,
                .disabled: theme.copy(
                    backgroundColor: style.disabledBackgroundColor,
                    foregroundColor: style.disabledForegroundColor
                ),
            ]
        ).frame(height: size.height)
    }
}
