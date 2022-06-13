// // Copyright 2022 P2P Validator Authors. All rights reserved.
// // Use of this source code is governed by a MIT-style license that can be
// // found in the LICENSE file.
//
// import BEPureLayout
// import Foundation
// import PureLayout
// import UIKit
//
// public class IconButton: ButtonControl<> {
//     /// On pressed callback
//     let imageView = BERef<UIImageView>()
//     let titleView = BERef<UILabel>()
//
//     public var image: UIImage {
//         didSet {
//             imageView.image = image
//         }
//     }
//
//     public var title: String {
//         didSet { titleView.text = title }
//     }
//
//     init(image: UIImage, title: String) {
//         self.image = image
//         self.title = title
//         super.init(frame: .zero)
//     }
//
//     override func build() -> UIView {
//         BEHStack {
//             BEContainer {
//                 BECenter {
//                     UIImageView(image: image).bind(imageView)
//                 }
//             }
//             UILabel(text: title)
//                 .bind(titleView)
//         }
//     }
//
//     override func update(animated: Bool) {
//
//
//         super.update(animated: animated)
//     }
// }
