import UIKit
import Foundation
import SubviewAttachingTextView

/// Delegate for seed phrase text view
@objc public protocol SeedPhraseTextViewDelegate: AnyObject {
    @objc optional func seedPhrasesTextViewDidBeginEditing(_ textView: SeedPhrasesTextView)
    @objc optional func seedPhrasesTextViewDidEndEditing(_ textView: SeedPhrasesTextView)
    @objc optional func seedPhrasesTextViewDidChange(_ textView: SeedPhrasesTextView)
    func seedPhrasesTextView(_ textView: SeedPhrasesTextView, didEnterPhrases phrases: String)
}

/// TextView that can handle seed phrase with indexes
public class SeedPhrasesTextView: SubviewAttachingTextView {
    // MARK: - Properties
    
    /// Default font for texts
    private let defaultFont = UIFont.systemFont(ofSize: 15)
    
    /// Mark as pasting
    private var isPasting = false
    
    /// Cache for phrase
    private var phrasesCached = ""
    
    /// Replacement for default delegate
    public weak var forwardedDelegate: SeedPhraseTextViewDelegate?
    
    /// Prevent default delegation
    public override weak var delegate: UITextViewDelegate? {
        didSet {
            guard let delegate = delegate else {
                return
            }

            if !(delegate is Self) {
                fatalError("Use forwardedDelegate instead")
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
//        placeholder = L10n.enterSeedPhrasesInACorrectOrderToRecoverYourWallet
        delegate = self
        autocapitalizationType = .none
        autocorrectionType = .no

        // add first placeholder
        addFirstPlaceholderAttachment()
    }

    /// Disable initializing with storyboard
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func paste(_ sender: Any?) {
        super.paste(sender)
        isPasting = true
    }

    // MARK: - Methods
    
    /// Get current entered phrases
    public func getPhrases() -> [String] {
        let attributedText = NSMutableAttributedString(attributedString: attributedText)
        self.attributedText
            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
                if att is PlaceholderAttachment {
                    attributedText.replaceCharacters(in: range, with: " ")
                }
            }
        let text = attributedText.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: " ")
    }
    
    /// Clear text view
    public func clear() {
        text = nil
//        addPlaceholderAttachment(at: 0)
//        selectedRange = NSRange(location: 1, length: 0)
    }
    
    /// Rect for cursor
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
        forwardedDelegate?.seedPhrasesTextViewDidBeginEditing?(self)
    }

    public func textViewDidEndEditing(_: UITextView) {
        forwardedDelegate?.seedPhrasesTextViewDidEndEditing?(self)
    }

    public func textViewDidChange(_: UITextView) {
        forwardedDelegate?.seedPhrasesTextViewDidChange?(self)
    }

    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // pasting
        if isPasting {
            handlePasting(range: range, text: text)
            markAsChanged()
            return false
        }

        // if deleting
        if text.isEmpty {
            handleDeleting(range: range)
            markAsChanged()
            return false
        }

        // add index when found a space
        if text.contains(" ") {
            addIndex()
            markAsChanged()
            return false
        }
        
        // allow only lowercased letters
        insertOnlyLetters(range: range, text: text)
        markAsChanged()
        return false
    }
    
    // MARK: - Helpers
    
    private func handlePasting(range: NSRange, text: String) {
        let text = text.lettersAndSpaces
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .removeExtraSpaces()
        
        // find all indexes of spaces
        var indexes = [Int]()
        for (index, char) in text.enumerated() where char == " " {
            indexes.append(index)
        }
        
        // replace all spaces with attachments
        var addingAttributedString = NSMutableAttributedString(string: text, attributes: typingAttributes)
        for index in indexes {
            let spaceRange = NSRange(location: index, length: 1)
            addingAttributedString.replaceCharacters(in: spaceRange, with: placeholderAttachment(index: index))
        }
        
        // if stand at the begining, or prev character is not a placeholder, add attachment
        if range.location == 0 || !attributedText.containsAttachments(in: NSRange(location: range.location - 1, length: 1)) {
            let attachment = placeholderAttachment(index: 0)
            attachment.append(addingAttributedString)
            addingAttributedString = attachment
        }
        
        // paste to range
        textStorage.replaceCharacters(in: range, with: addingAttributedString)
        
        // rearrange
        rearrangeAttachments()
        
        // move cursor
        DispatchQueue.main.async { [weak self] in
            self?.selectedRange = NSRange(location: range.location + addingAttributedString.length, length: 0)
        }
        
        isPasting = false
    }
    
    private func handleDeleting(range: NSRange) {
        // check if remove all character
        let newText = NSMutableAttributedString(attributedString: attributedText)
        newText.replaceCharacters(in: range, with: "")
        
        // remove
        textStorage.replaceCharacters(in: range, with: "")
        
        if newText.length == 0 {
            // remove all
            addFirstPlaceholderAttachment()
        } else {
            
            // remove others
            rearrangeAttachments()
            selectedRange = .init(location: range.location, length: 0)
        }
    }
    
    private func addIndex() {
        // get all phrases
        let selectedLocation = selectedRange.location
        
        if selectedLocation > 0,
           attributedText.containsAttachments(in: NSRange(location: selectedLocation - 1, length: 1))
        {
            return
        }

        // recalculate selected range
        let attachment = placeholderAttachment(index: phraseIndex(at: selectedLocation))
        textStorage.replaceCharacters(in: selectedRange, with: attachment)
        selectedRange = NSRange(location: selectedLocation + 1, length: 0)
        
        rearrangeAttachments()
    }
    
    private func insertOnlyLetters(range: NSRange, text: String) {
        let allowedCharacters = CharacterSet.lowercaseLetters
        let characterSet = CharacterSet(charactersIn: text.lowercased())
        
        if allowedCharacters.isSuperset(of: characterSet) {
            var range = range
            
            // if selected all text
            if range == NSRange(location: 0, length: attributedText.length) {
                textStorage.replaceCharacters(in: range, with: "")
                let attachment = placeholderAttachment(index: 0)
                textStorage.replaceCharacters(in: NSRange(location: 0, length: 0), with: attachment)
                range = NSRange(location: 1, length: 0)
            }
            
            textStorage.replaceCharacters(in: range, with: text.lowercased())
            selectedRange = NSRange(location: range.location + text.count, length: 0)
        }
    }

    private func rearrangeAttachments() {
        var count = 0
        attributedText
            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
                if att is PlaceholderAttachment {
                    let att = placeholderAttachment(index: count)
                    textStorage.replaceCharacters(in: range, with: att)
                    count += 1
                }
            }
    }
    
    private func addFirstPlaceholderAttachment() {
        let attachment = placeholderAttachment(index: 0)
        textStorage.replaceCharacters(in: NSRange(location: 0, length: 0), with: attachment)
        selectedRange = NSRange(location: 1, length: 0)
    }
    
    private func markAsChanged() {
        forwardedDelegate?.seedPhrasesTextViewDidChange?(self)
        let newPhrases = getPhrases().joined(separator: " ")
        if newPhrases != phrasesCached {
            forwardedDelegate?.seedPhrasesTextView(self, didEnterPhrases: newPhrases)
            phrasesCached = newPhrases
        }
    }
}

private extension String {
    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
    var lettersAndSpaces: String {
        return String(unicodeScalars.filter({ scalar in
            CharacterSet.letters.contains(scalar) ||
            CharacterSet(charactersIn: " ").contains(scalar)
        }))
    }
}
