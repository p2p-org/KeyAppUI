import Foundation
import BEPureLayout
import KeyAppUI
import UIKit

class TextFieldSection: BECompositionView {
    
    override func build() -> UIView {
        BEVStack(spacing: 10) {
            UILabel(text: "Text Fields", textSize: 22).padding(.init(only: .top, inset: 20))
            
            for i in [true, false] {
                SeedPhrasesTextView()
                    .setup { tv in
                        tv.forwardedDelegate = self
                    }
                
                let leftView: UIView = {
                    BEHStack {
                        UILabel(text: "🇦🇷", textSize: 24, weight: .bold)
                        UIImageView(width: 8, height: 16, imageNamed: "expand", contentMode: .scaleAspectFit)
                            .padding(.init(only: .left, inset: 4))
                        BESpacer.spacer
                    }.frame(width: 44, height: 32)
                }()
                
                let rightView: UIView = {
                    BEHStack {
                        BESpacer.spacer
                        UIImageView(width: 14, height: 16, imageNamed: "copy", contentMode: .scaleAspectFit)
                    }.frame(width: 20, height: 32)
                }()
                
                BaseTextFieldView(leftView: leftView, rightView: rightView, isBig: i).setup { input in
                    input.topTip("The tip or an error message")
                    input.bottomTip("The tip or an error message")
                    input.style = .error
                    input.constantPlaceholder = "••••••••••"
                    input.leftViewMode = .always
                    input.rightViewMode = .always
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .default
                    input.topTip("label")
                    input.bottomTip("the tip or an error message")
                    input.placeholder = "Default Placeholder"
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .default
                    input.topTip("label")
                    input.bottomTip("the tip or an error message")
                    input.text = "+44"
                    input.constantPlaceholder = "+44 7400 123456"
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .success
                    input.topTip("label")
                    input.bottomTip("the tip or an error message")
                    input.text = "+44"
                    input.constantPlaceholder = "+44 7400 123456"
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.topTip("The tip or an error message")
                    input.bottomTip("The tip or an error message")
                    input.style = .default
                    input.constantPlaceholder = "••••••••••"
                    input.text = "•••"
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .default
                    input.constantPlaceholder = "••••••••••"
                    input.text = "•••"
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .default
                    input.constantPlaceholder = "••••••••••"
                    input.text = "•••"
                    input.bottomTip("The tip or an error message")
                }

                BaseTextFieldView(leftView: nil, rightView: nil, isBig: i).setup { input in
                    input.style = .default
                    input.constantPlaceholder = "••••••••••"
                    input.text = "secret wor"
                    input.bottomTip("The tip or an error message")
                }
            }
        }
    }
}

extension TextFieldSection: SeedPhraseTextViewDelegate {
    func seedPhrasesTextView(_ textView: SeedPhrasesTextView, didEnterPhrases phrases: String) {
        print(phrases)
    }
}
