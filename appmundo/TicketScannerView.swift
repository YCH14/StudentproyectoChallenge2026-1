import SwiftUI

struct TicketScannerView: View {
    // Definición de colores
    let backgroundColor = Color(red: 0.98, green: 0.96, blue: 0.88)
    let boxColor = Color(red: 0.48, green: 0.53, blue: 0.55)

    // Gradiente para el número '26'
    let numberGradient = LinearGradient(
        gradient: Gradient(colors: [Color.green, Color.orange]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            // Fondo
            backgroundColor
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Número grande 26
                Text("26")
                    .font(.system(size: 160, weight: .bold))
                    .foregroundStyle(numberGradient)
                    .padding(.top, -20)

                // Caja central
                VStack(spacing: 20) {
                    Text("Estás list@ para una\nexperiencia inolvidable?")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // --- BOTÓN DE NAVEGACIÓN A SCANNERVIEW ---
                    NavigationLink {
                        ScannerView()
                    } label: {
                        Text("Continuar con el escaneo")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.blue)
                            )
                        // CLAVE: Asegura que el área de toque funcione
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(boxColor)
                        .shadow(radius: 10)
                        .frame(height: 180)
                )
                .padding(.horizontal, 40)
                .padding(.vertical, 30)

                Spacer()

                // Mascota
                Image("MascotasImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 450, height: 300)
                    .padding(.bottom, -80)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TicketScannerView()
        }
    }
}
