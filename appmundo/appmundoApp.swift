import SwiftUI

@main
struct appmundoApp: App {
    
    @StateObject var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            // Conecta el NavigationStack al manager para permitir popToRoot()
            NavigationStack(path: $navigationManager.path) {
                // TicketScannerView es la vista raíz
                TicketScannerView()
            }
            // Inyecta el manager para que todas las sub-vistas puedan usarlo
            .environmentObject(navigationManager)
        }
    }
}
