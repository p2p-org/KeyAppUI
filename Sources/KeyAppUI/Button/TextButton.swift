// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import PureLayout
import UIKit

public class TextButton: UIControl {
    // MARK: Properties

    /// On pressed callback
    var onPressed: BEVoidCallback?

    /// Animation configuration
    let propertiesAnimator = UIViewPropertyAnimator(duration: 0.12, curve: .easeInOut)

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

    var themes: [ThemeState: Theme] = [:] {
        didSet { update() }
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

    internal init(leadingImage: UIImage? = nil, title: String, trailingImage: UIImage? = nil, themes: [ThemeState: Theme]) {
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.title = title
        self.themes = themes

        // Set default theme in case themes is empty
        if self.themes[.normal] == nil {
            self.themes[.normal] = .default()
        }

        super.init(frame: .zero)

        // Build
        let child = build()
        addSubview(child)
        child.autoPinEdgesToSuperviewEdges()

        // Update
        update(animated: false)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func build() -> UIView {
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
            constraint.priority = .defaultLow
        }
        .frame(height: theme.minHeight)
    }

    // MARK: Applying theme

    /// Current theme base on button state
    var theme: Theme {
        if state.contains(.disabled) {
            return themes[.disabled] ?? themes[.normal]!
        }
        return themes[.normal]!
    }

    /// Apply current theme to button
    func update(animated: Bool = true) {
        titleView.textColor = theme.foregroundColor
        leadingImageView.tintColor = theme.foregroundColor
        trailingImageView.tintColor = theme.foregroundColor

        titleView.font = theme.font
        container.view?.heightConstraint?.constant = theme.minHeight
        layer.cornerRadius = theme.borderRadius

        leadingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing
        trailingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing

        propertiesAnimator.stopAnimation(true)

        if animated {
            propertiesAnimator.addAnimations { [weak self] in self?.updateAnimated() }
            propertiesAnimator.startAnimation()
        } else {
            updateAnimated()
        }
    }

    /// Applying part with animation
    func updateAnimated() {
        if state.contains(.highlighted) {
            backgroundColor = theme.highlightColor
        } else {
            backgroundColor = theme.backgroundColor
        }
    }

    // MARK: Touches handler

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if onPressed != nil || state.contains(.disabled) { isHighlighted = true }
        update()

        super.touchesBegan(touches, with: event)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: superview) else { return }
        isHighlighted = false

        if frame.contains(location) {
            if !state.contains(.disabled) { onPressed?() }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { [weak self] in self?.update() }
        } else {
            update()
        }

        super.touchesEnded(touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        update()
        super.touchesCancelled(touches, with: event)
    }
    
    @discardableResult
    public func onPressed(_ callback: @escaping BEVoidCallback) -> Self {
        onPressed = callback
        return self
    }

    override public var isEnabled: Bool {
        get { super.isEnabled }
        set {
            super.isEnabled = newValue
            update()
        }
    }
}
