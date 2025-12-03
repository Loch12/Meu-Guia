import UIKit

// MARK: - TourDetailViewControllerProtocol
protocol TourDetailViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
  func reloadInfo()
}

// MARK: - TourDetailViewController
class TourDetailViewController: BaseViewController<TourDetailView> {
  // MARK: - Properties
  let viewModel: TourDetailViewModelProtocol

  // MARK: - Init
  init(viewModel: TourDetailViewModelProtocol) {
    self.viewModel = viewModel

    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    title = .placeListingTitle
    setupActions()
    setupDelegates()
    viewModel.fetchTourDetail()
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
extension TourDetailViewController: UITableViewDelegate, UITableViewDataSource {
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
extension TourDetailViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.filterPlaces(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
  }
}

// MARK: - TourDetailViewControllerProtocol
extension TourDetailViewController: TourDetailViewControllerProtocol {
  func reloadInfo() {
    baseView.reloadData()
  }
}
