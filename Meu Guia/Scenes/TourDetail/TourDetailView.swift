import UIKit

// MARK: - TourDetail
class TourDetailView: BaseView {
  private lazy var searchBar: UISearchBar = {
    let view = UISearchBar()
    view.backgroundImage = UIImage()
    view.searchBarStyle = .minimal
    view.placeholder = .searchPlaceText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var tableView: UITableView = {
    let view = UITableView()
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = false
    view.registerReusableCell(PlaceTableViewCell.self)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  override func setup() {
    addSubviews(searchBar, tableView)
    if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
      textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "",
                                                           attributes: [.foregroundColor: UIColor.white])
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

extension TourDetailView {
  func setupDelegate(delegate: UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate) {
    tableView.delegate = delegate
    tableView.dataSource = delegate
    searchBar.delegate = delegate
  }

  func reloadData(tour: TourModel) {
    setTableHeaderView(tour: tour)
    tableView.reloadData()
  }

  func setTableHeaderView(tour: TourModel) {
    let contentView = TourDetailHeaderView()
    contentView.configure(tour: tour)

    let containerView = UIView()
    containerView.backgroundColor = .clear
    containerView.addSubview(contentView)
    let targetWidth = UIScreen.main.bounds.width

    contentView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: containerView.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),

      containerView.widthAnchor.constraint(equalToConstant: targetWidth),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8)
    ])

    let fittingSize = CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height)

    containerView.setNeedsLayout()
    containerView.layoutIfNeeded()

    let height = containerView.systemLayoutSizeFitting(fittingSize).height
    containerView.frame = CGRect(x: 0, y: 0, width: targetWidth, height: height)

    tableView.tableHeaderView = containerView
  }
}
