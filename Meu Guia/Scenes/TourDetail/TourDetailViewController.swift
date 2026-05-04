import UIKit

// MARK: - TourDetailViewControllerProtocol
protocol TourDetailViewControllerProtocol: AnyObject, BaseViewControllerProtocol {
  func reloadInfo()
}

// MARK: - TourDetailViewController
class TourDetailViewController: BaseViewController<TourDetailView> {
  // MARK: - Properties
  let viewModel: TourDetailViewModelProtocol
  var isSearching: Bool = false

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

    baseView.delegate = self
    baseView.setupButton(isOnline: viewModel.isOnline)
    setupActions()
    setupDelegates()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    viewModel.fetchTour {
      self.reloadInfo()
    }
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
    viewModel.getHowManyPlaces() == 0 ? viewModel.didSelectPlaceholder(isSearching: isSearching) : viewModel.didSelect(at: indexPath)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getHowManyPlaces() == 0 ? 1 : viewModel.getHowManyPlaces()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let place = viewModel.getPlace(by: indexPath.row) else {
      let cell = TourPlaceholderTableViewCell()
      cell.configure(placeholder: viewModel.getPlaceholderMessage(isSearching: isSearching))
      return cell
    }

    let cell = tableView.dequeueReusableCell(for: indexPath) as PlaceTableViewCell
    cell.configure(text: place.name)
    return cell
  }
}

// MARK: - SearchBar
extension TourDetailViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    isSearching = !searchText.isEmpty
    viewModel.filterPlaces(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    searchBar.resignFirstResponder()
  }
}

// MARK: - TourDetailViewControllerProtocol
extension TourDetailViewController: TourDetailViewControllerProtocol {
  func reloadInfo() {
    guard let tour = viewModel.getTour() else { return }
    baseView.reloadData(tour: tour)
  }
}

// MARK: - TourDetailViewDelegate
extension TourDetailViewController: TourDetailViewDelegate {
  func saveTour() {
    let message: String = viewModel.saveTour() ? .saveTourSuccessMessage : .saveTourFailureMessage
    showAlert(message: message)
  }
  
  func deleteTour() {
    showAlert(message: .deleteTourWarning, cancelOption: true) {
      self.viewModel.deleteTour {
        self.successfulDelete()
      }
    }
  }
  
  func successfulDelete() {
    showAlert(message: .successDeleteTour) {
      self.viewModel.returnToListing()
    }
  }
}
