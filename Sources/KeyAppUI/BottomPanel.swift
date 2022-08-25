// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation
import BEPureLayout

public class BottomPanel: BECompositionView {
    let child: UIView

    public override init() {
        child = UIView()
        super.init(frame: .zero)
    }

    public required init(@BEViewBuilder builder: Builder) {
        child = builder().build()
        super.init(frame: .zero)
    }
    
    public override func build() -> UIView {
        BEContainer {
            child
        }
            .backgroundColor(color: Asset.Colors.night.color)
            .roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 24)
    }
}
