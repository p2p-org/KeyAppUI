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

        var foreground: UIColor {
            switch self {
            case .primary, .ghostLime: return UIColor(red: 0.894, green: 0.953, blue: 0.071, alpha: 1)
            case .primaryWhite, .ghostWhite: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            case .second, .third, .ghost, .inverted: return UIColor(red: 0.167, green: 0.167, blue: 0.167, alpha: 1)
            case .invertedRed: return UIColor(red: 0.922, green: 0.29, blue: 0.478, alpha: 1)
            }
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

        var minHeight: CGFloat {
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

    enum Configuration: CaseIterable {
        case leftArrow
        case rightArrow
    }

    static func style(title: String, style: Style, size: Size, config: Set<Configuration> = []) -> TextButton {
        TextButton(
            leadingImage: config.contains(.leftArrow) ? Icons.arrowBack24px.image : nil,
            title: title,
            trailingImage: config.contains(.rightArrow) ? Icons.arrowForward24px.image : nil,
            theme: .init(
                backgroundColor: style.backgroundColor,
                foregroundColor: style.foreground,
                highlightColor: style.highlight,
                font: style.font.withSize(size.fontSize),
                contentPadding: .init(
                    top: 0,
                    left: config.contains(.leftArrow) ? 14 : 20,
                    bottom: 0,
                    right: config.contains(.rightArrow) ? 14 : 20
                ),
                iconSpacing: 8,
                borderRadius: size.borderRadius,
                minHeight: size.minHeight
            )
        )
    }
}