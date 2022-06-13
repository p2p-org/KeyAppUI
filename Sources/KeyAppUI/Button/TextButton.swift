// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import PureLayout
import UIKit

public class TextButton: UIControl {
    let container = BERef<UIView>()
    let titleView = BERef<UILabel>()

    let leadingSpacing = BERef<UIView>()
    let trailingSpacing = BERef<UIView>()

    let leadingImageView = BERef<UIImageView>()
    let leadingIconSpacing = BERef<UIView>()

    let trailingImageView = BERef<UIImageView>()
    let trailingIconSpacing = BERef<UIView>()

    var onPressed: BEVoidCallback?

    public var title: String {
        didSet { titleView.text = title }
    }

    public var leadingImage: UIImage? {
        didSet {
            leadingImageView.image = leadingImage
            leadingImageView.isHidden = leadingImage == nil
            leadingIconSpacing.view?.isHidden = leadingImage == nil
        }
    }

    public var trailingImage: UIImage? {
        didSet {
            trailingImageView.image = trailingImage
            trailingImageView.isHidden = trailingImage == nil
            trailingIconSpacing.view?.isHidden = trailingImage == nil
        }
    }

    var themes: [TextButtonThemeState:Theme] = [:] {
        didSet { update() }
    }
    
    var theme: TextButtonTheme {
        didSet { update() }
    }
    
    internal init(leadingImage: UIImage? = nil, title: String, trailingImage: UIImage? = nil, theme: TextButtonTheme) {
        self.leadingImage = leadingImage
        self.trailingImage = trailingImage
        self.title = title
        self.theme = theme

        super.init(frame: .zero)

        backgroundColor = theme.backgroundColor
        clipsToBounds = true
        layer.cornerRadius = theme.borderRadius

        // Build button
        let child = build()
        addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
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
                }
            }
        }
        .bind(container)
        .frame(height: theme.minHeight)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update() {
        print(state == .highlighted)

        titleView.textColor = theme.foregroundColor
        leadingImageView.tintColor = theme.foregroundColor
        trailingImageView.tintColor = theme.foregroundColor

        titleView.font = theme.font
        container.view?.heightConstraint?.constant = theme.minHeight
        layer.cornerRadius = theme.borderRadius

        leadingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing
        trailingIconSpacing.view?.widthConstraint?.constant = theme.iconSpacing

        propertiesAnimator.stopAnimation(true)
        propertiesAnimator.addAnimations { [weak self] in self?.animation() }
        propertiesAnimator.startAnimation()
    }

    func animation() {
        if state.contains(.highlighted) {
            backgroundColor = theme.highlightColor
        } else {
            backgroundColor = theme.backgroundColor
        }
    }

    lazy var propertiesAnimator = UIViewPropertyAnimator(duration: 0.12, curve: .easeInOut)

    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        update()

        super.touchesBegan(touches, with: event)
    }

    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: superview) else { return }
        isHighlighted = false

        if frame.contains(location) {
            onPressed?()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { [weak self] in self?.update() }
        } else {
            update()
        }

        super.touchesEnded(touches, with: event)
    }

    @discardableResult
    public func onPressed(_ callback: @escaping BEVoidCallback) -> Self {
        onPressed = callback
        return self
    }
}
