// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import KeyAppUI

class IconButtonSection: BECompositionView {
    
    var copiedToClipboardCompletionHandler: ((String) -> Void)?
    
    func withCopiedToClipboardCompletionHandler(_ handler: @escaping ((String) -> Void)) -> Self {
        self.copiedToClipboardCompletionHandler = handler
        return self
        
    }
    
    override func build() -> UIView {
        BEVStack {
            UILabel(text: "Icon buttons", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
            BEVStack(spacing: 8, alignment: .fill) {
                UILabel(text: "With text", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
                iconButton(title: "text")

                UILabel(text: "Without text", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
                iconButton(title: nil)
            }
        }
    }

    private func iconButton(title: String?) -> UIView {
        BEVStack(spacing: 8) {
            for style in IconButton.Style.allCases {
                BEHStack(spacing: 8, alignment: .center, distribution: .fill) {
                    for size in IconButton.Size.allCases {
                        IconButton.style(
                            image: Asset.MaterialIcon.appleLogo.image,
                            title: title,
                            style: style,
                            size: size
                        )
                            .onPressed {
                                let text = UIPasteboard.general.copyIconButtonGenerationCodeToClipboard(style: style, size: size)
                                self.copiedToClipboardCompletionHandler?(text)
                            }
                    }
                    UIView.spacer
                }
            }
        }
    }
}
