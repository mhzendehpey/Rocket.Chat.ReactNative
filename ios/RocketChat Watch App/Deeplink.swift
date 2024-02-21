import Foundation

protocol Deeplinking {
	func executeIfNeeded()
}

final class Deeplink: Deeplinking {
	@Dependency private var database: ServersDatabase
	@Dependency private var holder: NotificationResponseHolding
	@Dependency private var router: AppRouting
	
	func executeIfNeeded() {
		guard let response = holder.response else {
			return
		}
		
		guard let server = database.server(url: response.host) else {
			return
		}
		
		router.route(to: .roomList(server))
	}
}
