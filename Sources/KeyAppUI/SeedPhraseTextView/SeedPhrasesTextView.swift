import UIKit
import Foundation
import SubviewAttachingTextView

/// Delegate for seed phrase text view
public protocol SeedPhraseTextViewDelegate: AnyObject {
    func seedPhrasesTextViewDidBeginEditing(_ textView: SeedPhrasesTextView)
    func seedPhrasesTextViewDidEndEditing(_ textView: SeedPhrasesTextView)
    func seedPhrasesTextViewDidChange(_ textView: SeedPhrasesTextView)
}

/// TextView that can handle seed phrase with indexes
public class SeedPhrasesTextView: SubviewAttachingTextView {
    // MARK: - Properties
    
    /// Default font for texts
    private let defaultFont = UIFont.systemFont(ofSize: 15)
    
    /// Prevent dupplicating wraping phrases
    private var shouldWrapPhrases = false
    
    /// Prevent dupplicating rearranging
    private var shouldRearrange = false
    
    /// Mark as pasting
    private var isPasting = false
    
    /// Replacement for default delegate
    public weak var forwardedDelegate: SeedPhraseTextViewDelegate?
    
    /// Prevent default delegation
    public override weak var delegate: UITextViewDelegate? {
        didSet {
            guard let delegate = delegate else {
                return
            }

            if !(delegate is Self) {
                fatalError("Use phrases text view delegate instead")
            }
        }
    }

    // MARK: - Initializers
    
    /// Default initializer
    public init() {
        super.init(frame: .zero, textContainer: nil)
        configureForAutoLayout()
        isScrollEnabled = false

        backgroundColor = .clear
        tintColor = .black

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10

        typingAttributes = [
            .font: defaultFont,
            .paragraphStyle: paragraphStyle,
        ]

        heightAnchor.constraint(greaterThanOrEqualToConstant: 70)
            .isActive = true
//        placeholder = L10n.enterSeedPhrasesInACorrectOrderToRecoverYourWallet
        delegate = self
        autocapitalizationType = .none
        autocorrectionType = .no

        // add first placeholder
        addPlaceholderAttachment(at: 0)
        selectedRange = NSRange(location: 1, length: 0)
    }

    /// Disable initializing with storyboard
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            // place cursor at the end
            self?.selectedRange.location = self?.attributedText.length ?? 0
        }
    }

    // MARK: - Methods
    
    /// Get current entered phrases
    public func getPhrases() -> [String] {
        let text = attributedText.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: " ")
    }
    
    /// Clear text view
    public func clear() {
        text = nil
//        addPlaceholderAttachment(at: 0)
//        selectedRange = NSRange(location: 1, length: 0)
    }

    public override func closestPosition(to _: CGPoint) -> UITextPosition? {
        let beginning = beginningOfDocument
        let end = position(from: beginning, offset: attributedText.length)
        return end
    }

    public override func caretRect(for position: UITextPosition) -> CGRect {
        var original = super.caretRect(for: position)
        let height: CGFloat = 20
        original.origin.y += (original.size.height - 20) / 2
        original.size.height = height
        return original
    }
}

// MARK: - Forward delegate

extension SeedPhrasesTextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_: UITextView) {
        forwardedDelegate?.seedPhrasesTextViewDidBeginEditing(self)
    }

    public func textViewDidEndEditing(_: UITextView) {
        forwardedDelegate?.seedPhrasesTextViewDidEndEditing(self)
    }

    public func textViewDidChange(_: UITextView) {
        if shouldWrapPhrases {
            wrapPhrase()
        }

        if shouldRearrange {
            rearrangeAttachments()
        }

        forwardedDelegate?.seedPhrasesTextViewDidChange(self)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // pasting
        if isPasting {
            // TODO: - Paste
            isPasting = false
            return false
        }
        
        // disable
        shouldWrapPhrases = false
        shouldRearrange = false

        // if deleting
        if text.isEmpty {
            // check if remove all character
            let newText = NSMutableAttributedString(attributedString: attributedText)
            newText.replaceCharacters(in: range, with: text)
            if newText.length == 0 {
                textStorage.replaceCharacters(in: range, with: text)
                addPlaceholderAttachment(at: 0)
                selectedRange = NSRange(location: 1, length: 0)
                return false
            }

            // remove others
            shouldRearrange = true
            return true
        }

        // prevent dupplicated attachments
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            // prevent space at the begining
            if range.location == 0 { return false }
            
            // prevent 2 attachment next to each other
            else {
                // if prev location is an attachment
                if attributedText.containsAttachments(in: NSRange(location: range.location - 1, length: 1))
                {
                    return false
                }
                
                // if next location is an attachment
//                else if attributedText.length > range.location &&
//                    attributedText.containsAttachments(in: NSRange(location: range.location, length: 1))
//                {
//                    return false
//                }
            }
        }

        // wrap phrase when found a space
        if text.contains(" ") {
            wrapPhrase()
            rearrangeAttachments()
            shouldWrapPhrases = true
            shouldRearrange = true
            return false
        }
        
        // allow only lowercased letters
        let allowedCharacters = CharacterSet.lowercaseLetters
        let characterSet = CharacterSet(charactersIn: text.lowercased())
        
        if allowedCharacters.isSuperset(of: characterSet) {
            var range = range
            
            // if selected all text
            if range == NSRange(location: 0, length: attributedText.length) {
                textStorage.replaceCharacters(in: NSRange(location: 0, length: 1), with: placeholderAttachment(index: 0))
                range = NSRange(location: 1, length: attributedText.length - 1)
            }
            
            textStorage.replaceCharacters(in: range, with: text.lowercased())
            selectedRange = NSRange(location: range.location + text.count, length: 0)
        }
        return false
    }

    func wrapPhrase(addingPlaceholderAttachment: Bool = true) {
        // get all phrases
        let selectedLocation = selectedRange.location

        shouldWrapPhrases = false

        // recalculate selected range
        if addingPlaceholderAttachment {
            addPlaceholderAttachment(at: selectedLocation)
            selectedRange = NSRange(location: selectedLocation + 1, length: 0)
        }
    }

    fileprivate func rearrangeAttachments() {
        var count = 0
        attributedText
            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
                if att is PlaceholderAttachment {
                    let att = placeholderAttachment(index: count)
                    textStorage.replaceCharacters(in: range, with: att)
                    count += 1
                }
            }
        shouldRearrange = false
    }
}
