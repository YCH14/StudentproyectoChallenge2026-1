import SwiftUI

struct ScannerView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var shouldNavigateToValidation = false
    
    // Variable de estado para simular la detección del código
    @State private var isCodeDetected = false

    // Definición de colores
    let backgroundColor = Color(red: 0.98, green: 0.96, blue: 0.88)
    let instructionBoxColor = Color(red: 0.25, green: 0.55, blue: 0.85)
    
    // MODIFICACIÓN CLAVE DE COLORES:
    // Base: Amarillo (Buscando)
    // Detected: Verde (Encontrado/Listo)
    let baseBorderColor = Color.yellow // Inicia en amarillo
    let detectedBorderColor = Color.green // Cambia a verde al detectar
    
    // Gradiente para el número '26'
    let numberGradient = LinearGradient(
        gradient: Gradient(colors: [Color.green, Color.orange]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            VStack {
                // Mensaje de instrucción (sin cambios)
                Text("Posiciona tu código dentro del\nrecuadro")
                    // ... (Estilos omitidos)
                    .padding(.top, 40)
                
                Spacer()

                // --- VISTA DE CÁMARA (CameraView) ---
                ZStack {
                    // La fuente de video real.
                    CameraView(isCodeDetected: $isCodeDetected)
                        .frame(width: 300, height: 350)
                        .cornerRadius(30)
                        .clipped()
                    
                    // 2. El borde dinámico de guía
                    RoundedRectangle(cornerRadius: 30)
                        // Borde dinámico: Usa verde si isCodeDetected es true, sino usa amarillo base.
                        .stroke(isCodeDetected ? detectedBorderColor : baseBorderColor, lineWidth: 5)
                        .frame(width: 300, height: 350)
                        
                        // EFECTO GLOW: El brillo se activa con el color de detección (verde)
                        .shadow(color: isCodeDetected ? detectedBorderColor : .clear,
                                radius: isCodeDetected ? 15 : 0)
                        .animation(.easeInOut(duration: 0.3), value: isCodeDetected) // Animación suave
                }
                .padding(.vertical, 40)
                
                Spacer()

                // Número "26"
                Text("26")
                    // ... (Estilos omitidos)
                    .padding(.bottom, 20)
            }
        }
        
        // El NavigationLink oculto que activa la transición a ValidationView
        .navigationDestination(isPresented: $shouldNavigateToValidation) {
            ValidationView()
        }
        
        // Inicia la navegación y simula la detección
        .onAppear {
            // Simulación: Después de 2.0 segundos de "búsqueda" (amarillo), simula la detección
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                
                // 1. Simula la detección (El borde cambia de amarillo a verde)
                isCodeDetected = true
                
                // 2. Navega después de 0.5 segundos (tiempo para que el usuario vea el borde verde)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shouldNavigateToValidation = true
                }
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        ScannerView()
    }
}

