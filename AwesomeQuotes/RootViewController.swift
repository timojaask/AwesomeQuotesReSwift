import UIKit

class RootViewController: UIViewController {
    let containerView = UIView()

    init() {
        super.init(nibName: nil, bundle: nil)
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = containerView
    }
}

