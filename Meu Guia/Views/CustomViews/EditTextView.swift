import UIKit

class EditTextView: UIView {
  // MARK: - Properties
  private var textViewHeightConstraint: NSLayoutConstraint!
  
  // MARK: - Components
  private let titleLabel: BaseLabel = {
    let label = BaseLabel()
    label.numberOfLines = 0
    label.font = .nunito(.bold, textStyle: .title1, size: 22)
    label.textColor = .primaryColor
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let textView: UITextView = {
    let view = UITextView()
    view.layer.borderColor = UIColor.buttonBaseColor.cgColor
    view.layer.borderWidth = 2
    view.layer.cornerRadius = 7
    view.isScrollEnabled = false
    view.font = .nunito(.semiBold, textStyle: .body, size: 18)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubviews(titleLabel, textView)
    
    textView.delegate = self
    
    setupConstraints()
  }
  
  func setupConstraints() {
    textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 40)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
      textView.leadingAnchor.constraint(equalTo: leadingAnchor),
      textView.trailingAnchor.constraint(equalTo: trailingAnchor),
      textViewHeightConstraint,
      
      bottomAnchor.constraint(equalTo: textView.bottomAnchor)
    ])
  }
  
  func configure(title: String?) {
    titleLabel.text = title
  }
  
  func hasValidText() -> Bool {
    textView.text.isNotEmpty
  }
  
  func setupText(text: String?) {
    textView.text = text
    
    DispatchQueue.main.async { [weak self] in
      self?.updateSize()
    }
  }
  
  func getValue() -> String? {
    textView.text
  }
  
  func updateSize() {
    let newSize = textView.sizeThatFits(
      CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude)
    )
    
    textViewHeightConstraint.constant = max(40, newSize.height)
  }
}

// MARK: - UITextViewDelegate
extension EditTextView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    updateSize()
  }
}
