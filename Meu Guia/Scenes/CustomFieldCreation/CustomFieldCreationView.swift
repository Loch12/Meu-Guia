import UIKit

protocol CustomFieldCreationViewDelegate: BaseViewControllerProtocol {
  func confirmCreation()
  func cancelCreation()
}

// MARK: - CustomFieldCreationView
class CustomFieldCreationView: BaseView {
  // MARK: - Properties
  var delegate: CustomFieldCreationViewDelegate?
  
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
    view.configure(title: .titleFieldCreation)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var valueView: EditTextView = {
    let view = EditTextView()
    view.configure(title: .contentFieldText)
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
    editView.addSubviews(titleView, valueView, confirmButton, cancelButton)
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
      
      valueView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
      valueView.leadingAnchor.constraint(equalTo: editView.leadingAnchor, constant: 16),
      valueView.trailingAnchor.constraint(equalTo: editView.trailingAnchor, constant: -16),
      
      confirmButton.heightAnchor.constraint(equalToConstant: 48),
      confirmButton.topAnchor.constraint(equalTo: valueView.bottomAnchor, constant: 32),
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
    titleView.hasValidText() && valueView.hasValidText()
  }
  
  func getTitle() -> String? {
    titleView.getValue()
  }
  
  func getContent() -> String? {
    valueView.getValue()
  }
}
