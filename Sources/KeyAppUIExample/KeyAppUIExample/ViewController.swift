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
        
        view.backgroundColor = UIColor(red: 0.9569, green: 0.9569, blue: 0.9569, alpha: 1.0)
    }

    func build() -> UIView {
        BEScrollView {
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

            // Buttons
            UILabel(text: "Buttons", textSize: 22).padding(.init(only: .top, inset: 20))
            BEVStack(spacing: 8) {
                for style in TextButton.Style.allCases {
                    BEHStack(spacing: 8, alignment: .center, distribution: .fillEqually) {
                        for size in TextButton.Size.allCases {
                            TextButton.style(
                                title: "Button",
                                style: style,
                                size: size,
                                config: [.rightArrow]
                            ).onPressed { print("tap") }
                        }
                    }
                }
            }
        }.padding(.init(x: 16, y: 0))
    }
}
