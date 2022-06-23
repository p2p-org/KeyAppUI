import UIKit
import BEPureLayout

public final class SplashViewController: BEViewController {

    private let customView: SplashView

    public init(text: String) {
        self.customView = SplashView(text: text)
        super.init()
    }

    public override func setUp() {
        let child = customView.build()
        self.view.addSubview(child)
        child.autoPinEdgesToSuperviewEdges()
        customView.completionHandler = { [weak self] in
            self?.dismiss(animated: true)
        }
    }

    public func run() {
        customView.animate()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.run()
    }
}
