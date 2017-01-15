import CoreSpotlight
import MobileCoreServices

@objc(NorthPluginSpotlight) class NorthPluginSpotlight : CDVPlugin {

	private func isDefined(configItem: AnyObject!) -> Bool {
		return configItem != nil && !(configItem as! String).isEmpty
	}

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

	func indexItem(_ command: CDVInvokedUrlCommand) {
		var pluginResult = CDVPluginResult(
			status: CDVCommandStatus_ERROR
		)

		// Get the object

		let thingToIndex: [String: Any] = command.argument(at: 0) as! [String : Any]
		

		let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
		
		attributeSet.title = thingToIndex["title"] as? String
		attributeSet.contentDescription = thingToIndex["description"] as? String

		let item = CSSearchableItem(uniqueIdentifier: "\(thingToIndex["id"] as? String)", domainIdentifier: thingToIndex["domain"] as? String, attributeSet: attributeSet)
		
		CSSearchableIndex.default().indexSearchableItems([item]) { error in
			if let error = error {
				print("Indexing error: \(error.localizedDescription)")
				pluginResult = CDVPluginResult(
					status: CDVCommandStatus_ERROR,
					messageAs: "Indexing error: \(error.localizedDescription)"
				)
			} else {
				print("Search item successfully indexed!")
				pluginResult = CDVPluginResult(
					status: CDVCommandStatus_OK
				)
			}
		}
		
		self.commandDelegate!.send(
			pluginResult,
			callbackId: command.callbackId
		)
	}

	func removeIndexedItem(_ command: CDVInvokedUrlCommand) {
		var pluginResult = CDVPluginResult(
			status: CDVCommandStatus_ERROR
		)

        let idToRemove = command.arguments[0] as? String ?? ""

        
		CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: ["\(idToRemove)"]) { error in
	        if let error = error {
	            print("Deindexing error: \(error.localizedDescription)")

	            pluginResult = CDVPluginResult(
					status: CDVCommandStatus_ERROR,
					messageAs: "Indexing error: \(error.localizedDescription)"
				)
	        } else {
	            print("Search item successfully removed!")

	            pluginResult = CDVPluginResult(
					status: CDVCommandStatus_OK
				)
	        }
	    }

		self.commandDelegate!.send(
			pluginResult,
			callbackId: command.callbackId
		)
	}
}