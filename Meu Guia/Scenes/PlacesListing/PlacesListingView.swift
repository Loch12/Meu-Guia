import UIKit

// MARK: - PlacesListing
class PlacesListingView: BaseView {
  private lazy var searchBar: UISearchBar = {
    let view = UISearchBar()
    view.backgroundImage = UIImage()
    view.searchBarStyle = .minimal
    view.placeholder = "Busque um local desejado"
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = .white
    view.separatorStyle = .none
    view.bounces = false
    view.registerReusableCell(PlaceTableViewCell.self)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func setup() {
    backgroundColor = .white
    addSubviews(searchBar, tableView)
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

extension PlacesListingView {
  func setupDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
  }
}
