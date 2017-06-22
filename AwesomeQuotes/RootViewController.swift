import UIKit
import Cartography

class RootViewController: UIViewController {
    let containerView = UIView()
    let label = UILabel()

    init() {
        super.init(nibName: nil, bundle: nil)
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = true

        label.text = "Testing 1, 2, 3"
        containerView.addSubview(label)

        constrain(containerView, label) { (containerView, label) in
            label.center == containerView.center
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = containerView
    }
}

