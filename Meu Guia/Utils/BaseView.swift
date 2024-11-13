import UIKit

open class BaseView: UIView {
  // MARK: - Components
  private lazy var activity: CustomActivityIndicatorView = {
    let activity = CustomActivityIndicatorView()
    activity.isHidden = true
    activity.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
    activity.translatesAutoresizingMaskIntoConstraints = false
    return activity
  }()

  // MARK: - Init
  override public init(frame: CGRect) {
    super.init(frame: frame)

    setup()
    setupConstraints()
    setupActivityIndicator()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    setup()
    setupConstraints()
    setupActivityIndicator()
  }

  // MARK: - Open func
  open func setup() {}

  open func setupConstraints() {}

  func setupActivityIndicator() {
    addSubview(activity)

    NSLayoutConstraint.activate([
      activity.topAnchor.constraint(equalTo: topAnchor),
      activity.leadingAnchor.constraint(equalTo: leadingAnchor),
      activity.trailingAnchor.constraint(equalTo: trailingAnchor),
      activity.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  func startLoading() {
    activity.isHidden = false
    activity.startAnimating()
  }

  func stopLoading() {
    activity.stopAnimating()
    activity.isHidden = true
  }
}
