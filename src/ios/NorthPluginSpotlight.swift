@objc(NorthPluginSpotlight) class NorthPluginSpotlight : CDVPlugin {
  func echo(_ command: CDVInvokedUrlCommand) {
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let msg = command.arguments[0] as? String ?? ""

    if msg.characters.count > 0 {
      /* UIAlertController is iOS 8 or newer only. */
      let toastController: UIAlertController = 
        UIAlertController(
          title: "", 
          message: msg, 
          preferredStyle: .alert
        )

      self.viewController?.present(
        toastController, 
        animated: true, 
        completion: nil
      )

      let duration = Double(NSEC_PER_SEC) * 3.0

      pluginResult = CDVPluginResult(
        status: CDVCommandStatus_OK,
        messageAs: msg
      )
    }

    self.commandDelegate!.send(
      pluginResult, 
      callbackId: command.callbackId
    )
  }
}