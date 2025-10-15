import SwiftUI

struct FailureView: View {
    // Para volver a la pantalla anterior (pop a ValidationView)
    @Environment(\.dismiss) var dismiss
    
    // Acceso a la función de navegación a la raíz (TicketScannerView)
    @EnvironmentObject var navigationManager: NavigationManager

    // Definición de colores
    let backgroundColor = Color(red: 0.75, green: 0.28, blue: 0.28)
    let mainTextColor = Color(red: 0.98, green: 0.65, blue: 0.65)
    let buttonColor = Color(red: 0.90, green: 0.80, blue: 0.88)
    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()
                
                // --- Título de Error ---
                Text("No se\nreconoció el\ncódigo")
                    .font(.system(size: 65, weight: .bold))
                    .foregroundColor(mainTextColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.top, 50)
                
                Spacer()
                
                // --- 1. Botón Volver a escanear (Destino: ScannerView) ---
                Button {
                    // ACCIÓN: El 'dismiss()' aquí hace un pop para salir de FailureView.
                    // Luego, el 'onDisappear' de ValidationView hace un pop adicional
                    // para llegar directamente a SCANNERVIEW.
                    dismiss()
                } label: {
                    Text("Volver a\nescanear")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 250, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(buttonColor)
                        )
                }
                
                // --- 2. Botón Salir (Destino: TicketScannerView) ---
                Button {
                    // ACCIÓN: Vuelve a la vista raíz (TicketScannerView).
                    navigationManager.popToRoot()
                } label: {
                    Text("Salir")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 250, height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(buttonColor)
                        )
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FailureView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FailureView()
        }
        .environmentObject(NavigationManager())
    }
}

