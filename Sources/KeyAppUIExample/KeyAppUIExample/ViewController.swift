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
                    icon: Asset.MaterialIcon.arrowBack.image.withTintColor(Asset.Colors.sun.color, renderingMode: .alwaysOriginal),
                    text: "Some importan importan",
                    buttonTitle: "Action",
                    buttonAction: {
                        SnackBar(icon: Asset.MaterialIcon.addBox.image, text: "Autodismissing toast", buttonTitle: "Close", buttonAction: {
                            SnackBar.hide()
                        }).show(in: self, autodismiss: true)
                    }
                )
                
                SnackBarView(
                    icon: .checkmark,
                    text: "No Button"
                )

                SnackBarView(
                    icon: Asset.MaterialIcon.arrowBack.image.withTintColor(Asset.Colors.sun.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"
                )

                SnackBarView(
                    icon: Asset.MaterialIcon.arrowBack.image.withTintColor(Asset.Colors.sun.color, renderingMode: .alwaysOriginal),
                    text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                    buttonTitle: "Something") {
                        SnackBar(icon: Asset.MaterialIcon.addBox.image, text: "Non-autodismissing toast", buttonTitle: "Close", buttonAction: {
                            SnackBar.hide()
                        }).show(in: self, autodismiss: false)
                    }
            }//.padding(.init(top: 0, left: 15, bottom: 0, right: 15))
            
            
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
