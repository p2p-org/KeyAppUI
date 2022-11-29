import UIKit
import Foundation

/// Delegate for seed phrase text view
@objc public protocol SeedPhraseTextViewDelegate: AnyObject {
    @objc optional func seedPhrasesTextViewDidBeginEditing(_ textView: SeedPhrasesTextView)
    @objc optional func seedPhrasesTextViewDidEndEditing(_ textView: SeedPhrasesTextView)
    @objc optional func seedPhrasesTextViewDidChange(_ textView: SeedPhrasesTextView)
    func seedPhrasesTextView(_ textView: SeedPhrasesTextView, didEnterPhrases phrases: String)
}

/// TextView that can handle seed phrase with indexes
public class SeedPhrasesTextView: UITextView {
    // MARK: - Properties
    
    /// Default font for texts
    private let defaultFont = UIFont.systemFont(ofSize: 15)
    
    /// Separator between phrases
    private let phraseSeparator = "   " // 3 spaces
    
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
        insertIndexAtSelectedRangeAndMoveCursor()
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
//        let attributedText = NSMutableAttributedString(attributedString: attributedText)
//        self.attributedText
//            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
//                if att is PlaceholderAttachment {
//                    attributedText.replaceCharacters(in: range, with: " ")
//                }
//            }
//        let text = attributedText.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return text.components(separatedBy: " ")
    }
    
    /// Clear text view
    public func clear() {
        text = nil
//        addPlaceholderAttachment(at: 0)
//        selectedRange = NSRange(location: 1, length: 0)
    }
    
    /// Rect for cursor
//    public override func caretRect(for position: UITextPosition) -> CGRect {
//        var original = super.caretRect(for: position)
//        let height: CGFloat = 20
//        original.origin.y += (original.size.height - 20) / 2
//        original.size.height = height
//        return original
//    }
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
            handleSpace()
            markAsChanged()
            return false
        }
        
        // allow only lowercased letters
        insertOnlyLetters(range: range, text: text)
        markAsChanged()
        return false
    }
    
    // MARK: - Handlers
    
    private func handlePasting(range: NSRange, text: String) {
//        let text = text.lettersAndSpaces
//            .lowercased()
//            .trimmingCharacters(in: .whitespacesAndNewlines)
//            .removeExtraSpaces()
//
//        // find all indexes of spaces
//        var indexes = [Int]()
//        for (index, char) in text.enumerated() where char == " " {
//            indexes.append(index)
//        }
//
//        // replace all spaces with attachments
//        var addingAttributedString = NSMutableAttributedString(string: text, attributes: typingAttributes)
//        for index in indexes {
//            let spaceRange = NSRange(location: index, length: 1)
//            addingAttributedString.replaceCharacters(in: spaceRange, with: placeholderAttachment(index: index))
//        }
//
//        // if stand at the begining, or prev character is not a placeholder, add attachment
//        if range.location == 0 || !attributedText.containsAttachments(in: NSRange(location: range.location - 1, length: 1)) {
//            let attachment = placeholderAttachment(index: 0)
//            attachment.append(addingAttributedString)
//            addingAttributedString = attachment
//        }
//
//        // paste to range
//        textStorage.replaceCharacters(in: range, with: addingAttributedString)
//
//        // rearrange
//        rearrangeAttachments()
//
//        // move cursor
//        DispatchQueue.main.async { [weak self] in
//            self?.selectedRange = NSRange(location: range.location + addingAttributedString.length, length: 0)
//        }
        
        isPasting = false
    }
    
    private func handleDeleting(range: NSRange) {
//        // check if remove all character
//        let newText = NSMutableAttributedString(attributedString: attributedText)
//        newText.replaceCharacters(in: range, with: "")
//
//        // remove
//        textStorage.replaceCharacters(in: range, with: "")
//
//        if newText.length == 0 {
//            // remove all
//            addFirstPlaceholderAttachment()
//        } else {
//
//            // remove others
//            rearrangeAttachments()
//            selectedRange = .init(location: range.location, length: 0)
//        }
    }
    
    private func handleSpace() {
        // if cursor is in the middle of the text
        if selectedRange.location > 0 {
            // if there is already an index before current cursor, ignore it
            if hasIndexBeforeCurrentSelectedLocation() {
                return
            }
            // if there is no index before current cursor,
            // add separator
            else {
                insertSeparatorAtSelectedRangeAndMoveCursor()
            }
        }

        // insert index at current selected location
        insertIndexAtSelectedRangeAndMoveCursor()
        
        // rearrange indexes
        rearrangeIndexes()
    }
    
    private func insertOnlyLetters(range: NSRange, text: String) {
        let allowedCharacters = CharacterSet.lowercaseLetters
        let characterSet = CharacterSet(charactersIn: text.lowercased())
        
        if allowedCharacters.isSuperset(of: characterSet) {
            var range = range
            
            // if selected all text
            if range == NSRange(location: 0, length: attributedText.length) {
                textStorage.replaceCharacters(in: range, with: "")
                let attachment = indexAttributedString(index: 0)
                textStorage.replaceCharacters(in: NSRange(location: 0, length: 0), with: attachment)
                range = NSRange(location: 1, length: 0)
            }
            
            textStorage.replaceCharacters(in: range, with: text.lowercased())
            selectedRange = NSRange(location: range.location + text.count, length: 0)
        }
    }

    private func rearrangeIndexes() {
//        var count = 0
//        attributedText
//            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
//                if att is PlaceholderAttachment {
//                    let att = placeholderAttachment(index: count)
//                    textStorage.replaceCharacters(in: range, with: att)
//                    count += 1
//                }
//            }
    }
    
    private func markAsChanged() {
        forwardedDelegate?.seedPhrasesTextViewDidChange?(self)
        let newPhrases = getPhrases().joined(separator: " ")
        if newPhrases != phrasesCached {
            forwardedDelegate?.seedPhrasesTextView(self, didEnterPhrases: newPhrases)
            phrasesCached = newPhrases
        }
    }
    
    // MARK: - Helpers

    private func insertSeparatorAtSelectedRangeAndMoveCursor() {
        let separatorAttributedString = NSAttributedString(string: phraseSeparator, attributes: typingAttributes)
        insertAttributedStringAtSelectedRangeAndMoveCursor(separatorAttributedString)
    }
    
    private func insertIndexAtSelectedRangeAndMoveCursor() {
        let phraseIndex = phraseIndex(at: selectedRange.location)
        let indexAttributedString = indexAttributedString(index: phraseIndex)
        insertAttributedStringAtSelectedRangeAndMoveCursor(indexAttributedString)
    }
    
    private func insertAttributedStringAtSelectedRangeAndMoveCursor(_ attributedString: NSAttributedString) {
        textStorage.replaceCharacters(in: selectedRange, with: attributedString)
        selectedRange = NSRange(location: selectedRange.location + attributedString.length, length: 0)
    }
    
    private func hasIndexBeforeCurrentSelectedLocation() -> Bool {
        let location = selectedRange.location
        // index max "24. ", min "1. " (min 3 character)
        guard location >= 3 else { return false}
        
        // check index by using regex
        let regex = try! NSRegularExpression(pattern: #"[1..9]+. "#)
        guard let result = regex.matches(in: text, range: NSRange( location: 0, length: text.count)).last
        else {
            return false
        }
        
        // if find result exactly before the location
        return result.range.location + result.range.length == location
    }

    private func indexAttributedString(index: Int) -> NSMutableAttributedString {
        .init(string: "\(index). ", attributes: typingAttributes)
//        let label = UILabel(text: "\(index + 1)", textColor: Asset.Colors.mountain.color)
//            .padding(.init(top: 0, left: index == 0 ? 0: 16, bottom: 0, right: 2))
//        label.translatesAutoresizingMaskIntoConstraints = true
//
//        // replace text by attachment
//        let attachment = PlaceholderAttachment(view: label)
//        let attrString = NSMutableAttributedString(attachment: attachment)
//        attrString.addAttributes(typingAttributes, range: NSRange(location: 0, length: attrString.length))
//        return attrString
    }

    private func phraseIndex(at location: Int) -> Int {
//        var count = 0
//        attributedText
//            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
//                if range.location > location { return }
//                if att is PlaceholderAttachment {
//                    count += 1
//                }
//            }
//        return count
        return 1
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
