import UIKit

// MARK: - TourDetailViewDelegate
protocol TourDetailViewDelegate: AnyObject {
  func saveTour()
  func deleteTour()
}

// MARK: - TourDetail
class TourDetailView: BaseView {
  // MARK: - Properties
  var delegate: TourDetailViewDelegate?
  
  // MARK: - Components
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
  
  private lazy var actionButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 7
    button.titleLabel?.font = .nunito(.bold, textStyle: .title1, size: 18)
    return button
  }()

  override func setup() {
    addSubviews(searchBar, tableView, actionButton)
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
      searchBar.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -8),
      
      actionButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
      actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      actionButton.heightAnchor.constraint(equalTo: searchBar.heightAnchor, constant: -20),
      actionButton.widthAnchor.constraint(equalToConstant: 100),

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
    tableView.reloadData()
  }
  
  func setupButton(isOnline: Bool) {
    actionButton.backgroundColor = isOnline ? .validGreen : .invalidRed
    actionButton.setTitle(isOnline ? "Salvar" : "Excluir", for: .normal)
    let action = isOnline ? #selector(saveTourAction) : #selector(deleteTourAction)
    actionButton.addTarget(self, action: action, for: .touchUpInside)
  }
  
  @objc func saveTourAction() {
    delegate?.saveTour()
  }
  
  @objc func deleteTourAction() {
    delegate?.deleteTour()
  }
}
