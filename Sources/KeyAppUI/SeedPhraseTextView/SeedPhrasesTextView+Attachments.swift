//
//  WLPhrasesTextView+Attachments.swift
//  p2p_wallet
//
//  Created by Chung Tran on 22/03/2021.
//

import UIKit
import Foundation
import SubviewAttachingTextView

extension SeedPhrasesTextView {
    // MARK: - Attachment types

    class Attachment: SubviewTextAttachment {
        override func attachmentBounds(
            for textContainer: NSTextContainer?,
            proposedLineFragment lineFrag: CGRect,
            glyphPosition position: CGPoint,
            characterIndex charIndex: Int
        ) -> CGRect {
            var bounds = super.attachmentBounds(
                for: textContainer,
                proposedLineFragment: lineFrag,
                glyphPosition: position,
                characterIndex: charIndex
            )
            bounds.origin.y -= 3.5
            return bounds
        }
    }

    class PlaceholderAttachment: Attachment {}
}

extension SeedPhrasesTextView {
    // MARK: - Methods

    func placeholderAttachment(index: Int) -> NSMutableAttributedString {
        let label = UILabel(text: "\(index + 1)", textColor: Asset.Colors.mountain.color)
            .padding(.init(top: 0, left: index == 0 ? 0: 16, bottom: 0, right: 2))
        label.translatesAutoresizingMaskIntoConstraints = true

        // replace text by attachment
        let attachment = PlaceholderAttachment(view: label)
        let attrString = NSMutableAttributedString(attachment: attachment)
        attrString.addAttributes(typingAttributes, range: NSRange(location: 0, length: attrString.length))
        return attrString
    }

    // MARK: - Helpers
    func phraseIndex(at location: Int) -> Int {
        var count = 0
        attributedText
            .enumerateAttribute(.attachment, in: NSRange(location: 0, length: attributedText.length)) { att, range, _ in
                if range.location > location { return }
                if att is PlaceholderAttachment {
                    count += 1
                }
            }
        return count
    }
}
