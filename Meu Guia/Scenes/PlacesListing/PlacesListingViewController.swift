import UIKit

// MARK: - PlacesListingViewControllerProtocol
protocol PlacesListingViewControllerProtocol: AnyObject {
  func reloadInfo()
}

// MARK: - PlacesListingViewController
class PlacesListingViewController: BaseViewController<PlacesListingView> {
  // MARK: - Properties
  let viewModel: PlacesListingViewModelProtocol

  // MARK: - Init
  init(viewModel: PlacesListingViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Locais"
    setupActions()
    setupDelegates()
  }

  func setupActions() {
    setupNavBarBackButton()
    hideKeyboardWhenTappedAround()
  }

  func setupDelegates() {
    viewModel.setupDelegate(delegate: self)
    baseView.setupDelegate(delegate: self)
  }
}

// MARK: - TableView
extension PlacesListingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.didSelect(at: indexPath)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getHowManyPlaces()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let place = viewModel.getPlace(by: indexPath.row) else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(for: indexPath) as PlaceTableViewCell
    cell.configure(text: place.name, image: place.image)
    return cell
  }
}

// MARK: - SearchBar
extension PlacesListingViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.filterPlaces(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

// MARK: - PlacesListingViewControllerProtocol
extension PlacesListingViewController: PlacesListingViewControllerProtocol {
  func reloadInfo() {
    baseView.reloadData()
  }
}
