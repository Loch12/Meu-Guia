import UIKit

protocol PlaceNavigationViewDelegate: BaseViewControllerProtocol {}

// MARK: - PlaceEditView
class PlaceNavigationView: BaseView {
  // MARK: - Properties
  var place: PlaceModel?
  var delegate: PlaceNavigationViewDelegate?
  
  // MARK: - Components

  // MARK: - Override Methods
  override func setup() {
    
  }

  override func setupConstraints() {
    NSLayoutConstraint.activate([
      
    ])
  }
}
