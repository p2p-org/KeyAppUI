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
            BEVStack(spacing: 15, alignment: .fill, distribution: .fill) {
                SnackBarView(
                    icon: .add,
                    text: "Some importan importan",
                    buttonTitle: "Button",
                    buttonAction: {
                        print("Got tap")
                    }
                )
                
                SnackBarView(
                    icon: .checkmark,
                    text: "Without Button"
                )
            }.padding(.init(top: 0, left: 15, bottom: 0, right: 15))
            
//            BEVStack {
//                UIButton(label: "SnackBar").onTap {
//
//                }
//            }
        }
        .setup { view in view.scrollView.keyboardDismissMode = .onDrag }
    }
}
