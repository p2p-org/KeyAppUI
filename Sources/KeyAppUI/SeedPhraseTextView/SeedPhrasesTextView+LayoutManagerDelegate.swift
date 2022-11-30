import Foundation
import UIKit

extension SeedPhrasesTextView: NSLayoutManagerDelegate {
    public func layoutManager(_ layoutManager: NSLayoutManager, shouldBreakLineByWordBeforeCharacterAt charIndex: Int) -> Bool {
        CharacterSet(charactersIn: "1234567890")
            .contains(text[charIndex].unicodeScalars.first!)
    }
}
