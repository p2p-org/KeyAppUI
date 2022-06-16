// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import Foundation
import KeyAppUI

func buttonSection() -> UIView {
    BEVStack {
        UILabel(text: "Buttons", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
        BEVStack(spacing: 8, alignment: .fill) {
            UILabel(text: "Normal", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
            generateButtons()

            UILabel(text: "With left icon", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
            generateButtons(leading: Asset.MaterialIcon.arrowBack.image)

            UILabel(text: "With right icon", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))
            generateButtons(trailing: Asset.MaterialIcon.arrowForward.image)

            UILabel(text: "Others", textSize: 22).padding(.init(top: 20, left: 0, bottom: 10, right: 0))

            // Create wallet example
            BEContainer {
                BEVStack(spacing: 8) {
                    TextButton.style(
                        title: "Create a new wallet",
                        style: .primary,
                        size: .large
                    ).onPressed {}
                    TextButton.style(
                        title: "I already have a wallet",
                        style: .ghost,
                        size: .large
                    ).onPressed {}
                }.padding(.init(x: 16, y: 20))
            }
            .box(cornerRadius: 32)
            .backgroundColor(color: .white)

            // Alert example
            BEContainer {
                BEVStack(spacing: 24) {
                    BECenter { UILabel(text: "Also you can know more") }
                    BEHStack(spacing: 8, distribution: .fillEqually) {
                        TextButton.style(
                            title: "Close",
                            style: .invertedRed,
                            size: .small
                        ).onPressed {}
                        TextButton.style(
                            title: "Show details",
                            style: .inverted,
                            size: .small
                        ).onPressed {}
                    }

                }.padding(.init(x: 16, y: 20))
            }
            .border(width: 1, color: .white)
            .box(cornerRadius: 32)

            // Pincode
            BEContainer {
                BEVStack(spacing: 24) {
                    BEHStack {
                        UILabel(text: "Your security key")
                        BESpacer(.horizontal)
                        TextButton
                            .style(title: "Paste", style: .third, size: .small, trailing: Asset.MaterialIcon.paste.image)
                            .onPressed {}
                    }
                    UITextField(placeholder: "Input")
                }
                .margin(.init(x: 8, y: 8))
                .backgroundColor(color: UIColor(red: 0.971, green: 0.978, blue: 0.996, alpha: 1))
                .box(cornerRadius: 16)
                .border(width: 1, color: UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1))
                .padding(.init(x: 16, y: 20))
            }
            .backgroundColor(color: .white)
            .box(cornerRadius: 32)
        }
    }
}

func generateButtons(leading: UIImage? = nil, trailing: UIImage? = nil) -> UIView {
    BEContainer {
        BEVStack(spacing: 8) {
            for style in TextButton.Style.allCases {
                BEHStack(spacing: 8, alignment: .center, distribution: .fillEqually) {
                    for size in TextButton.Size.allCases {
                        TextButton.style(
                            title: "Button",
                            style: style,
                            size: size,
                            leading: leading,
                            trailing: trailing
                        ).onPressed { print("tap") }
                    }
                }
            }
        }
    }
}