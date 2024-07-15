import UIKit

open class BaseView: UIView {
  override public init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setupConstraints()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
    setupConstraints()
  }

  open func setup() {}

  open func setupConstraints() {}
}
