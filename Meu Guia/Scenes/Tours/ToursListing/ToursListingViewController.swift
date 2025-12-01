import UIKit

// MARK: - ToursListingViewControllerProtocol
protocol ToursListingViewControllerProtocol: AnyObject {
  func reloadInfo()
}

// MARK: - ToursListingViewController
class ToursListingViewController: BaseViewController<ToursListingView> {
  // MARK: - Properties
  let viewModel: ToursListingViewModelProtocol

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

    title = .tourListingTitle
    setupActions()
    setupDelegates()
  }

  func setupActions() {
    setupNavBarBackButton()
    hideKeyboardWhenTappedAround()
  }

  func setupDelegates() {
    baseView.setupDelegate(delegate: self)
  }
}

// MARK: - TableView
extension ToursListingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelect(at: indexPath)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getHowManyTours()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let place = viewModel.getTour(by: indexPath.row) else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(for: indexPath) as PlaceTableViewCell
    cell.configure(text: place.name, image: nil)
    return cell
  }
}

// MARK: - SearchBar
extension ToursListingViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.filterTours(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

// MARK: - ToursListingViewControllerProtocol
extension ToursListingViewController: ToursListingViewControllerProtocol {
  func reloadInfo() {
    baseView.reloadData()
  }
}
