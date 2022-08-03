import UIKit
import BEPureLayout

public final class SplashViewController: BEViewController {
    
    public var completionHandler: (() -> Void)? {
        get { customView.completionHandler }
        set { customView.completionHandler = newValue }
    }

    private let customView = SplashView()

    public override func setUp() {
        let wrapper = customView
            .centered(.horizontal)
            .centered(.vertical)
            .backgroundColor(color: Asset.Colors.lime.color)

        self.view.addSubview(wrapper)
        wrapper.autoPinEdgesToSuperviewEdges()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.run()
    }

    private func run() {
        customView.animate()
    }
}
