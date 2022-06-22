import Foundation
import KeyAppUI
import UIKit

extension UIPasteboard {
    func copyIconButtonGenerationCodeToClipboard(style: IconButton.Style, size: IconButton.Size) -> String {
        var text = """
        IconButton.style(
            image: Asset.MaterialIcon.<#name#>.image,
            title: <#T##String#>,
            style: .\(style),
            size: .\(size)
        """
        text += """
        
        )
            .onPressed {
                <#code#>
            }
        """
        self.string = text
        return text
    }
    
    func copyTextButtonGenerationCodeToClipboard(style: TextButton.Style, size: TextButton.Size, hasLeading: Bool, hasTrailing: Bool) -> String {
        var text = """
        TextButton.style(
            title: <#T##String#>,
            style: .\(style),
            size: .\(size),
        """
        
        if hasLeading {
            text += """
            
                leading: Asset.MaterialIcon.<#name#>.image,
            """
        }
        
        if hasTrailing {
            text += """
            
                trailing: Asset.MaterialIcon.<#name#>.image,
            """
        }
        
        // remove last comma
        text = text.replacingLastOccurrenceOfString(",", with: "")
        
        text += """
        
        )
            .onPressed {
                <#code#>
            }
        """
        self.string = text
        return text
    }
}

