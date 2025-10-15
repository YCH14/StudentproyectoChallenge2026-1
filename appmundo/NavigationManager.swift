import Foundation
import SwiftUI

// La clase debe ser final y conformar a ObservableObject
final class NavigationManager: ObservableObject {
    
    // CLAVE: @Published es lo que le dice a SwiftUI
    // que redibuje el NavigationStack cuando 'path' cambia.
    @Published var path = NavigationPath()

    // Esta función resetea la pila, lo que dispara el cambio en 'path'.
    func popToRoot() {
        path = NavigationPath()
    }
}

