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
    }

    func build() -> UIView {
        BEScrollView {
            // Icons section
            UILabel(text: "Icons", textSize: 22)
            BEVStack {
                for iconsChunk in Icons.allImages.chunks(ofCount: 12) {
                    BEHStack {
                        for icon in iconsChunk { UIImageView(image: icon.image) }
                        UIView.spacer
                    }
                }
            }

            // Buttons
            BEVStack {
                Button(
                    content: "Button",//UILabel(text: "Button"),
                    theme: .init(
                        backgroundColor: .black,
                        foregroundColor: .green,
                        highlightColor: .gray
                    ),
                    size: .medium
                )
            }.padding(.init(x: 16, y: 0))
            

            BEVStack {
                UILabel(text: "Typography", textSize: 22)
                for style in UIFont.Style.allCases {
                    UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .regular))
                }
                for style in UIFont.Style.allCases {
                    UILabel().withAttributedText(UIFont.text(style.rawValue, of: style, weight: .bold))
                }
            }
        }
    }
}
