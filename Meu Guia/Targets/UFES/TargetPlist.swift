import Foundation

class TargetPlistGeneral: TargetUtilsGeneralProtocol {

}

class TargetPlistColor: TargetUtilsColorProtocol {
  var buttonBaseColor: String = "009EE1"

  var primaryColor: String = "1A3E70"

  var lightColor: String = "ABDBF4"
}

class TargetPlistString: TargetUtilsStringProtocol {
  var homeDescriptionText: String = "Seja bem vindo ao app acessível de localização da UFES"

  var targetName: String = "UFES"
}
