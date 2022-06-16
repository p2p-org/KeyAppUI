//
//  ViewController.swift
//  KeyAppUIExample
//
//  Created by Ivan on 09.06.2022.
//

import Algorithms
import BEPureLayout
import KeyAppUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let child = build()
        view.addSubview(child)
        child.autoPinEdgesToSuperviewEdges()

        view.backgroundColor = UIColor(red: 0.91, green: 0.92, blue: 0.95, alpha: 1)
    }

    func build() -> UIView {
        BEScrollView(contentInsets: .init(all: 16)) {
            BEVStack(spacing: 15, alignment: .fill, distribution: .fill) {
                UILabel(text: "SnackBar", textSize: 22).padding(.init(only: .top, inset: 20))
                SnackBarView(
                    icon: Asset.MaterialIcon.arrowBack.image.withTintColor(Asset.Colors.cloud.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing",
                    trailing: TextButton
                        .style(title: "Button", style: .primary, size: .medium)
                        .onPressed {
                            SnackBar(icon: .add, text: "Lorem ipsum dolor sit amet, conser adipiscing", buttonTitle: "Close", buttonAction: {
                                SnackBar.hide()
                            }).show(in: self, autoDismiss: true)
                        }
                )

                SnackBarView(
                    icon: .checkmark,
                    text: "No Button"
                )

                SnackBarView(
                    icon: Asset.MaterialIcon.addBox.image.withTintColor(Asset.Colors.sun.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing"
                )

                SnackBarView(
                    icon: Asset.MaterialIcon.flag.image.withTintColor(Asset.Colors.mint.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    trailing: TextButton
                        .style(title: "Button", style: .primary, size: .large)
                )
                SnackBarView(
                    icon: Asset.MaterialIcon.copy.image.withTintColor(Asset.Colors.rain.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    trailing: TextButton
                        .style(title: "Button", style: .primary, size: .medium)
                )
                SnackBarView(
                    icon: Asset.MaterialIcon.check.image.withTintColor(Asset.Colors.smoke.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    trailing: TextButton
                        .style(title: "Button", style: .primary, size: .small)
                )
            }

            BEVStack {
                // Icons section
                UILabel(text: "Icons", textSize: 22).padding(.init(only: .top, inset: 20))
                BEVStack {
                    for iconsChunk in Asset.MaterialIcon.allImages.chunks(ofCount: 12) {
                        BEHStack {
                            for icon in iconsChunk {
                                UIImageView(image: icon.image, contentMode: .scaleAspectFill)
                            }
                            UIView.spacer
                        }
                    }
                }

                BEVStack {
                    UILabel(text: "Typography", textSize: 22).padding(.init(only: .top, inset: 20))
                    for style in UIFont.Style.allCases {
                        UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .regular))
                    }
                    for style in UIFont.Style.allCases {
                        UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .bold))
                    }
                }

                // Buttons section
                buttonSection()

                // Icon buttons section
                iconButtonSection()
            }
        }
        .setup { view in view.scrollView.keyboardDismissMode = .onDrag }
    }
}
