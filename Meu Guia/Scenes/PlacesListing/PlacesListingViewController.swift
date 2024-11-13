import UIKit

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
    setupNavBarBackButton()
    baseView.setupDelegate(delegate: self, dataSource: self)
  }
}

extension PlacesListingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getHowManyPlaces()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let place = viewModel.getPlace(by: indexPath.row) else { return UITableViewCell() }

    let cell = tableView.dequeueReusableCell(for: indexPath) as PlaceTableViewCell
    cell.configure(text: place.name, image: .icHome)
    return cell
  }
}
