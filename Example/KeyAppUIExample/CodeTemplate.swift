// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import Foundation
import KeyAppUI
import UIKit

class CodeTemplate {
    public static func share(code: String) {
        guard let root = UIApplication.getTopViewController() else { return }
        UIPasteboard.general.string = code

        let notification = SnackBar(
            icon: Asset.MaterialIcon.copy.image.withTintColor(.white),
            text: "Code template has been copied to clipboard"
        )
        notification.show(in: root)
    }
}

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
