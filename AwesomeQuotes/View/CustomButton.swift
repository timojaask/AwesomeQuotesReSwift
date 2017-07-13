import UIKit

class CustomButton: UIButton {
    init(_ title: String) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: .normal)
        setTitleColor(.blue, for: .normal)
        setTitleColor(.gray, for: .disabled)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
