import UIKit

// MARK: - ToursListingViewControllerProtocol
protocol ToursListingViewControllerProtocol: BaseViewControllerProtocol {
  func reloadInfo()
}

// MARK: - ToursListingViewController
class ToursListingViewController: BaseViewController<ToursListingView> {
  // MARK: - Properties
  let viewModel: ToursListingViewModelProtocol
  var isSearching: Bool = false

  // MARK: - Init
  init(viewModel: ToursListingViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupActions()
    setupDelegates()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    baseView.tableView.isHidden = true
    viewModel.fetchTours()
  }

  func setupActions() {
    setupNavBarBackButton()
    hideKeyboardWhenTappedAround()
  }

  func setupDelegates() {
    baseView.setupDelegate(delegate: self)
    viewModel.setupDelegate(delegate: self)
  }
}

// MARK: - TableView
extension ToursListingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.getHowManyTours() == 0 ? viewModel.didSelectPlaceholder() : viewModel.didSelect(at: indexPath)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.getHowManyTours() == 0 ? 1 : viewModel.getHowManyTours()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tour = viewModel.getTour(by: indexPath.row) else {
      let cell = TourPlaceholderTableViewCell()
      cell.configure(isOnline: viewModel.isOnline, isSearching: isSearching)
      return cell
    }

    let cell = tableView.dequeueReusableCell(for: indexPath) as TourTableViewCell
    cell.configure(text: tour.name, image: nil)
    return cell
  }
}

// MARK: - SearchBar
extension ToursListingViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    isSearching = !searchText.isEmpty
    viewModel.filterTours(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    searchBar.resignFirstResponder()
  }
}

// MARK: - ToursListingViewControllerProtocol
extension ToursListingViewController: ToursListingViewControllerProtocol {
  func reloadInfo() {
    baseView.tableView.reloadData()
    baseView.tableView.isHidden = false
  }
}
