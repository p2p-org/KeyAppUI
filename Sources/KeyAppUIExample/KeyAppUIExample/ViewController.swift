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

        view.backgroundColor = UIColor(red: 0.922, green: 0.933, blue: 0.961, alpha: 1)
    }

    func build() -> UIView {
        BEScrollView {
            BEVStack {
                // Icons section
                UILabel(text: "Icons", textSize: 22).padding(.init(only: .top, inset: 20))
                BEVStack {
                    for iconsChunk in Icons.allImages.chunks(ofCount: 12) {
                        BEHStack {
                            for icon in iconsChunk { UIImageView(image: icon.image) }
                            UIView.spacer
                        }
                    }
                }

                BEVStack {
                    UILabel(text: "Typography", textSize: 22)
                    for style in UIFont.Style.allCases {
                        UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .regular))
                    }
                    for style in UIFont.Style.allCases {
                        UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .bold))
                    }
                }

                // Buttons section
                buttonSection()
            }
        }
        .setup { view in view.scrollView.keyboardDismissMode = .onDrag }
        .padding(.init(x: 16, y: 0))
    }
}
