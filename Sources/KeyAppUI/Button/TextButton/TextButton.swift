// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import PureLayout
import UIKit

/// A button where primary focus is text. Leading and trailing icons are secondary.
public class TextButton: ButtonControl<TextButtonTheme> {
    /// Button title text
    public var title: String {
        didSet { titleView.text = title }
    }

    /// Button leading icon image
    public var leadingImage: UIImage? {
        didSet {
            leadingImageView.image = leadingImage
            leadingImageView.isHidden = leadingImage == nil
            leadingIconSpacing.view?.isHidden = leadingImage == nil
        }
    }

    /// Button trailing icon image
    public var trailingImage: UIImage? {
        didSet {
            trailingImageView.image = trailingImage
            trailingImageView.isHidden = trailingImage == nil
            trailingIconSpacing.view?.isHidden = trailingImage == nil
        }
    }

    // MARK: Refs

    let container = BERef<UIView>()
    let titleView = BERef<UILabel>()

    let leadingSpacing = BERef<UIView>()
    let trailingSpacing = BERef<UIView>()

    let leadingImageView = BERef<UIImageView>()
    let leadingIconSpacing = BERef<UIView>()

    let trailingImageView = BERef<UIImageView>()
    let trailingIconSpacing = BERef<UIView>()

    // MARK: Init

    public init(leadingImage: UIImage? = nil, title: String, trailingImage: UIImage? = nil, themes: ThemeState<TextButtonTheme>) {
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.title = title

        // Set default theme in case themes is empty
        var themes = themes
        if themes[.normal] == nil {
            themes[.normal] = .default()
            themes[.highlighted] = .default().copy(backgroundColor: .gray)
        }

        super.init(frame: .zero, themes: themes)
    }

    override func build() -> UIView {
        BEContainer {
            BECenter {
                BEHStack {
                    // Leading
                    BEContainer()
                        .frame(width: theme.contentPadding.left)
                        .bind(leadingSpacing)
                    UIImageView(image: leadingImage)
                        .bind(leadingImageView)
                        .frame(width: 20, height: 20)
                        .hidden(leadingImage == nil)
                        .setup { view in view.tintColor = theme.foregroundColor }
                    BEContainer()
                        .frame(width: theme.iconSpacing)
                        .hidden(leadingImage == nil)
                        .bind(leadingIconSpacing)

                    // Content
                    UILabel(text: title, font: theme.font)
                        .bind(titleView)
                        .setup { view in view.textColor = theme.foregroundColor }

                    // Trailing
                    BEContainer()
                        .frame(width: theme.iconSpacing)
                        .hidden(trailingImage == nil)
                        .bind(trailingIconSpacing)
                    UIImageView(image: trailingImage)
                        .bind(trailingImageView)
                        .frame(width: 20, height: 20)
                        .hidden(trailingImage == nil)
                        .setup { view in view.tintColor = theme.foregroundColor }
                    BEContainer()
                        .frame(width: theme.contentPadding.right)
                        .bind(trailingSpacing)
                }.withTag(1)
            }
        }
        .bind(container)
        .setup { container in
            guard let content = container.viewWithTag(1) else { return }
            let constraint: NSLayoutConstraint = container.autoMatch(.width, to: .width, of: content, withMultiplier: 1.0, relation: .greaterThanOrEqual)
            
            constraint.priority = .defaultHigh
        }
    }

    // MARK: Applying theme

    /// Apply current theme to button
    override func update(animated: Bool = true) {
        titleView.textColor = theme.foregroundColor
        leadingImageView.tintColor = theme.foregroundColor
        trailingImageView.tintColor = theme.foregroundColor

        titleView.font = theme.font
        layer.cornerRadius = theme.borderRadius

        leadingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing
        trailingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing

        super.update(animated: animated)
    }

    override func updateAnimated() {
        backgroundColor = theme.backgroundColor
        super.updateAnimated()
    }
}
