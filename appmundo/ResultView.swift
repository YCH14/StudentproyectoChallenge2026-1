import SwiftUI

struct ResultView: View {
    // CLAVE: Necesario para que el botón pueda navegar a la raíz
    @EnvironmentObject var navigationManager: NavigationManager
    
    // Datos de ejemplo que se mostrarían dinámicamente
    let section: String = "E"
    let seat: String = "K10"
    
    // Definición de colores
    let backgroundColor = Color(red: 0.61, green: 0.82, blue: 0.58) // Verde claro de fondo
    let darkGreenColor = Color(red: 0.20, green: 0.38, blue: 0.20)  // Verde oscuro para texto y botones

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()
                
                // --- Título Principal ---
                Text("Bienvenid@\na esta\nmágica\nexperiencia")
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(darkGreenColor)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.top, 50)
                
                // --- Botones de Etiqueta (Sección y Asiento) ---
                HStack(spacing: 20) {
                    // Botón Sección
                    Text("Sección")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(darkGreenColor.opacity(0.8))
                        )
                    
                    // Botón Asiento
                    Text("Asiento")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 60)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(darkGreenColor.opacity(0.8))
                        )
                }
                
                // --- Resultados (Valores) ---
                HStack(spacing: 20) {
                    // Valor Sección
                    Text(section)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(darkGreenColor)
                        .frame(width: 150)
                    
                    // Valor Asiento
                    Text(seat)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(darkGreenColor)
                        .frame(width: 150)
                }
                
                Spacer() // Empuja el contenido hacia arriba
                
                // --- NUEVO: Botón Finalizar (Regresar a la Raíz) ---
                Button("Finalizar y Salir") {
                    // Acción: Vuelve a la vista raíz (TicketScannerView)
                    navigationManager.popToRoot()
                }
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(darkGreenColor)
                        .shadow(radius: 5)
                )
                .padding(.bottom, 50)
            }
            // Ocultamos la barra de navegación para un look inmersivo
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    NavigationStack {
        ResultView()
        // Inyección necesaria para que el Preview pueda usar popToRoot()
    }
    .environmentObject(NavigationManager())
}

