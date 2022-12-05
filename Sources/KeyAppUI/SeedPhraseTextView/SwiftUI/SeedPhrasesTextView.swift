import SwiftUI
import UIKit

struct SeedPhraseTextView: UIViewRepresentable {
    @Binding private var isFirstResponder: Bool
    @Binding private var text: String

    init(
        text: Binding<String>,
        isFirstResponder: Binding<Bool>
    ) {
        _text = text
        _isFirstResponder = isFirstResponder
    }

    func makeUIView(context: Context) -> UISeedPhrasesTextView {
        let view = UISeedPhrasesTextView()
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.forwardedDelegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UISeedPhrasesTextView, context _: Context) {
//        uiView.text = text
        uiView.paste(text)
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder)
    }

    class Coordinator: NSObject, UISeedPhraseTextViewDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>

        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>) {
            self.text = text
            self.isFirstResponder = isFirstResponder
        }
        
        func seedPhrasesTextView(_ textView: UISeedPhrasesTextView, didEnterPhrases phrases: String) {
            text.wrappedValue = phrases
        }
        
        func seedPhrasesTextViewDidBeginEditing(_ textView: UISeedPhrasesTextView) {
            isFirstResponder.wrappedValue = true
        }
        
        func seedPhrasesTextViewDidEndEditing(_ textView: UISeedPhrasesTextView) {
            isFirstResponder.wrappedValue = false
        }
    }
}
