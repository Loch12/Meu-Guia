import UIKit

// MARK: - ToursListing
class ToursListingView: BaseView {
  private lazy var searchBar: UISearchBar = {
    let view = UISearchBar()
    view.backgroundImage = UIImage()
    view.searchBarStyle = .minimal
    view.placeholder = .searchTourText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
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
    addSubviews(searchBar, tableView)
    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "",
                                                           attributes: [.foregroundColor: UIColor.primaryColor])
      textfield.backgroundColor = .lightColor
    }
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),

      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
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
