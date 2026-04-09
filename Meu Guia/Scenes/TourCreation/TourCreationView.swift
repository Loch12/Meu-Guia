import UIKit

protocol TourCreationViewDelegate: BaseViewControllerProtocol {
  func confirmCreation()
  func cancelCreation()
}

// MARK: - CustomFieldCreationView
class TourCreationView: BaseView {
  // MARK: - Properties
  var delegate: TourCreationViewDelegate?
  
  // MARK: - Components
  private lazy var editView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 7
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var titleView: EditTextView = {
    let view = EditTextView()
    view.configure(title: .tourNameCreation)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .invalidRed
    button.setTitle(.cancelAction, for: .normal)
    button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var confirmButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.saveAction, for: .normal)
    button.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()

  // MARK: - Override Methods
  override func setup() {
    backgroundColor = UIColor.black.withAlphaComponent(0.4)
    addSubviews(editView)
    editView.addSubviews(titleView, confirmButton, cancelButton)
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      editView.centerYAnchor.constraint(equalTo: centerYAnchor),
      editView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
      editView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
      editView.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 16),
      
      titleView.topAnchor.constraint(equalTo: editView.topAnchor, constant: 16),
      titleView.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
      titleView.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
      
      confirmButton.heightAnchor.constraint(equalToConstant: 48),
      confirmButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 32),
      confirmButton.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
      confirmButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
      
      cancelButton.heightAnchor.constraint(equalToConstant: 48),
      cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 4),
      cancelButton.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
      cancelButton.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
    ])
  }
  
  @objc func confirmAction() {
    delegate?.confirmCreation()
  }
  
  @objc func cancelAction() {
    delegate?.cancelCreation()
  }
  
  func checkValidation() -> Bool {
    titleView.hasValidText()
  }
  
  func getName() -> String? {
    titleView.getValue()
  }
}
