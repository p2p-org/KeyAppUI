// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import PureLayout
import UIKit

/// A button where primary focus is text. Leading and trailing icons are secondary.
public class TextButton: ButtonControl<TextButtonAppearance> {
    /// Button title text
    public var title: String {
        didSet { titleView.text = title }
    }

    /// Button leading icon image
    public var leadingImage: UIImage? {
        didSet {
            leadingImageView.image = leadingImage
            updateLeading()
        }
    }

    /// Button trailing icon image
    public var trailingImage: UIImage? {
        didSet {
            trailingImageView.image = trailingImage
            updateTrailing()
        }
    }

    public var isLoading: Bool = false {
        didSet {
            updateLeading()
            updateTrailing()
        }
    }

    // MARK: Refs

    private let container = BERef<UIView>()
    private let titleView = BERef<UILabel>()

    private let leading = BERef<UIView>()
    private let leadingSpacing = BERef<UIView>()
    private let leadingImageView = BERef<UIImageView>()
    private let leadingIconSpacing = BERef<UIView>()
    private let leadingLoadingIndicator = BERef<CircularProgressIndicator>()

    private let trailing = BERef<UIView>()
    private let trailingSpacing = BERef<UIView>()
    private let trailingImageView = BERef<UIImageView>()
    private let trailingIconSpacing = BERef<UIView>()
    private let trailingLoadingIndicator = BERef<CircularProgressIndicator>()

    // MARK: Init

    public init(leadingImage: UIImage? = nil, title: String, trailingImage: UIImage? = nil, themes: ThemeState<TextButtonAppearance>) {
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
            BEHStack {
                // Leading
                BEContainer()
                    .frame(width: theme.contentPadding.left)
                    .bind(leadingSpacing)

                BEHStack {
                    UIImageView(image: leadingImage)
                        .bind(leadingImageView)
                        .frame(width: 20, height: 20)
                        .hidden(leadingImage == nil)
                        .setup { view in view.tintColor = theme.foregroundColor }
                    CircularProgressIndicator(backgroundCircularColor: theme.loadingBackgroundColor, foregroundCircularColor: theme.foregroundColor)
                        .bind(leadingLoadingIndicator)
                        .hidden(!isLoading)
                        .frame(width: 20, height: 20)
                    BEContainer()
                        .frame(width: theme.iconSpacing)
                        .hidden(leadingImage == nil)
                        .bind(leadingIconSpacing)
                }
                .hidden(leadingImage == nil)
                .bind(leading)

                // Content
                UILabel(text: title, font: theme.font)
                    .bind(titleView)
                    .withContentCompressionResistancePriority(.required, for: .horizontal)
                    .setup { view in
                        view.textColor = theme.foregroundColor
                        view.adjustsFontSizeToFitWidth = true
                        view.textAlignment = .center
                    }

                // Trailing
                BEHStack {
                    BEContainer().frame(width: theme.iconSpacing)
                    UIImageView(image: trailingImage)
                        .bind(trailingImageView)
                        .frame(width: 20, height: 20)
                        .hidden(trailingImage == nil)
                        .setup { view in view.tintColor = theme.foregroundColor }
                    CircularProgressIndicator(backgroundCircularColor: theme.loadingBackgroundColor, foregroundCircularColor: theme.foregroundColor)
                        .bind(trailingLoadingIndicator)
                        .hidden(!isLoading)
                        .frame(width: 20, height: 20)
                }
                .hidden(trailingImage == nil)
                .bind(trailing)

                BEContainer()
                    .frame(width: theme.contentPadding.right)
                    .bind(trailingSpacing)
            }
            .centered(.vertical)
            .setup { view in
                let container = UIView(forAutoLayout: ())
                container.addSubview(view)
                container.tag = 1111
                view.autoPinEdge(toSuperviewEdge: .leading, withInset: 12, relation: .greaterThanOrEqual).priority = .defaultLow
                view.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12, relation: .greaterThanOrEqual).priority = .defaultLow
                view.autoAlignAxis(toSuperviewAxis: .horizontal)
            }
        }
        .bind(container)
    }

    // MARK: Applying theme

    /// Apply current theme to button
    override func update(animated: Bool = true) {
        titleView.textColor = theme.foregroundColor
        leadingImageView.tintColor = theme.foregroundColor
        trailingImageView.tintColor = theme.foregroundColor

        titleView.font = theme.font
        layer.cornerRadius = theme.borderRadius
        if let color = theme.borderColor {
            layer.borderWidth = 2
            layer.borderColor = color.cgColor
        }

        leadingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing
        trailingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing

        super.update(animated: animated)
    }

    override func updateAnimated() {
        backgroundColor = theme.backgroundColor
        super.updateAnimated()
    }

    func updateTrailing() {
        trailing.isHidden = trailingImage == nil
        trailingImageView.isHidden = isLoading || trailingImage == nil
        trailingLoadingIndicator.isHidden = !isLoading
    }

    func updateLeading() {
        leading.isHidden = leadingImage == nil
        leadingImageView.isHidden = isLoading || leadingImage == nil
        leadingLoadingIndicator.isHidden = !isLoading
    }
}
