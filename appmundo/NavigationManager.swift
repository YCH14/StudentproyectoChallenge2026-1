import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {
    
    // CLAVE: @Published es lo que hace que el botón funcione.
    @Published var path = NavigationPath()

    // Función que lleva de regreso a TicketScannerView (la vista raíz).
    func popToRoot() {
        path = NavigationPath()
    }
}
