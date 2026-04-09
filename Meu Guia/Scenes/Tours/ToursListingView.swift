import UIKit

protocol ToursListingViewDelegate: AnyObject {
  func createTour()
}

// MARK: - ToursListing
class ToursListingView: BaseView {
  // MARK: - Properties
  var delegate: ToursListingViewDelegate?
  
  // MARK: - Components
  private lazy var topStackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [searchBar, actionButton])
    view.axis = .horizontal
    view.spacing = 8
    view.alignment = .center
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var searchBar: UISearchBar = {
    let view = UISearchBar()
    view.backgroundImage = UIImage()
    view.searchBarStyle = .minimal
    view.placeholder = .searchTourText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var actionButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.isHidden = true
    button.backgroundColor = .buttonBaseColor
    button.setTitle(.createTourAction, for: .normal)
    button.addTarget(self, action: #selector(createTour), for: .touchUpInside)
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    button.isUserInteractionEnabled = true
    return button
  }()

  lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = false
    view.isHidden = true
    view.registerReusableCell(TourTableViewCell.self)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func setup() {
    addSubviews(topStackView, tableView)
    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "",
                                                           attributes: [.foregroundColor: UIColor.primaryColor])
      textfield.backgroundColor = .lightColor
    }
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      topStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
      topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      
      actionButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor, constant: -20),
      actionButton.widthAnchor.constraint(equalToConstant: 100),

      tableView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func setActionButton(hidden: Bool) {
    actionButton.isHidden = hidden
  }
  
  @objc func createTour() {
    delegate?.createTour()
  }
}

extension ToursListingView {
  func setupDelegate(delegate: UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate) {
    tableView.delegate = delegate
    tableView.dataSource = delegate
    searchBar.delegate = delegate
  }

  func reloadData() {
    tableView.reloadData()
  }
}
