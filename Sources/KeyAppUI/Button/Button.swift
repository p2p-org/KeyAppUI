// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import PureLayout
import UIKit

public enum ButtonSize {
    /// S-32
    case small

    /// S-48
    case medium

    /// S-56
    case large
}

public struct ButtonTheme {
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let highlightColor: UIColor

    public init(backgroundColor: UIColor, foregroundColor: UIColor, highlightColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.highlightColor = highlightColor
    }
}

public class Button: UIControl {
    let leading: UIView?
    let trailing: UIView?
    let title: String
    let theme: ButtonTheme

    let size: ButtonSize

    public init(leading: UIView? = nil, content: String, trailing: UIView? = nil, theme: ButtonTheme, size: ButtonSize) {
        self.leading = leading
        self.trailing = trailing
        self.title = content
        self.theme = theme
        self.size = size

        super.init(frame: .zero)

        let child = build()
        addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
    }

    func build() -> UIView {
        BEVStack {
            if let leading = leading { leading }
//            title
            if let trailing = trailing { trailing }
        }.backgroundColor(color: theme.backgroundColor)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
