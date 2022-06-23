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
                TextButton(
                    title: "Open splash",
                    style: .primary,
                    size: .large
                ).onPressed { [weak self] in
                    self?.presentSplash()
                }
                
                SnackBarSection(viewController: self)

                IconSection()

                TypographySection()
                
                // Buttons
                TextButtonSection()
                IconButtonSection()
            }
        }
        .setup { view in view.scrollView.keyboardDismissMode = .onDrag }
    }
    
    private func presentSplash() {
        let splashVC = SplashViewController(text: "key app")
        splashVC.modalPresentationStyle = .fullScreen
        present(splashVC, animated: true)
    }
}
