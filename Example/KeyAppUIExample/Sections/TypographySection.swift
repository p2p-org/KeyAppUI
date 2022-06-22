// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import KeyAppUI

class TypographySection: BECompositionView {
    override func build() -> UIView {
        BEVStack {
            UILabel(text: "Typography", textSize: 22).padding(.init(only: .top, inset: 20))
            for style in UIFont.Style.allCases {
                UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .regular))
            }
            for style in UIFont.Style.allCases {
                UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .bold))
            }
        }
    }
}
