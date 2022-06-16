// Copyright 2022 P2P Validator Authors. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import BEPureLayout
import KeyAppUI

class SnackBarSection: BECompositionView {
    weak var viewController: UIViewController?

    init(viewController: UIViewController?) {
        self.viewController = viewController
        super.init(frame: .zero)
    }

    override func build() -> UIView {
        BEVStack(spacing: 15, alignment: .fill, distribution: .fill) {
            UILabel(text: "SnackBar", textSize: 22).padding(.init(only: .top, inset: 20))
            SnackBarView(
                icon: Asset.MaterialIcon.arrowBack.image.withTintColor(Asset.Colors.cloud.color, renderingMode: .alwaysOriginal),
                text: "Lorem ipsum dolor sit amet, conser adipiscing",
                trailing: TextButton
                    .style(title: "Button", style: .primary, size: .medium)
                    .onPressed { [weak viewController] in
                        guard let viewController = viewController else { return }
                        SnackBar(icon: .add, text: "Lorem ipsum dolor sit amet, conser adipiscing", buttonTitle: "Close", buttonAction: {
                            SnackBar.hide()
                        }).show(in: viewController, autoDismiss: true)
                    }
            )

            SnackBarView(
                icon: .checkmark,
                text: "No Button"
            )

            SnackBarView(
                icon: Asset.MaterialIcon.addBox.image.withTintColor(Asset.Colors.sun.color, renderingMode: .alwaysOriginal),
                text: "Lorem ipsum dolor sit amet, conser adipiscing"
            )

            SnackBarView(
                icon: Asset.MaterialIcon.flag.image.withTintColor(Asset.Colors.mint.color, renderingMode: .alwaysOriginal),
                text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                trailing: TextButton
                    .style(title: "Button", style: .primary, size: .large)
            )
            SnackBarView(
                icon: Asset.MaterialIcon.copy.image.withTintColor(Asset.Colors.rain.color, renderingMode: .alwaysOriginal),
                text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                trailing: TextButton
                    .style(title: "Button", style: .primary, size: .medium)
            )
            SnackBarView(
                icon: Asset.MaterialIcon.check.image.withTintColor(Asset.Colors.smoke.color, renderingMode: .alwaysOriginal),
                text: "Lorem ipsum dolor sit amet, conser adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                trailing: TextButton
                    .style(title: "Button", style: .primary, size: .small)
            )
        }
    }
}
