import SwiftUI

struct ValidationView: View {
    // Para el botón de "Atrás" automático (se oculta)
    @Environment(\.dismiss) var dismiss
    
    // Variables de Estado para la animación y navegación
    @State private var validationProgress: Double = 0.0
    @State private var percentageText: Int = 0
    
    @State private var shouldNavigateToResult = false // Controla el salto al éxito
    @State private var shouldNavigateToFailure = false // Controla el salto a la falla
    
    // Bandera que decide el resultado (60% de éxito, 40% de falla)
    @State private var validationSuccess: Bool = (Int.random(in: 1...100) > 40)

    // Definición de colores
    let backgroundColor = Color(red: 0.94, green: 0.94, blue: 0.92) // Gris claro de fondo
    let messageBoxColor = Color(red: 0.69, green: 0.77, blue: 0.90) // Azul pálido de la caja de mensaje
    
    // Gradiente para la barra de progreso (verde a naranja)
    let progressAnimationGradient = LinearGradient(
        gradient: Gradient(colors: [Color.green, Color.orange]),
        startPoint: .leading,
        endPoint: .trailing
    )

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()

            VStack {
                Spacer() // Empuja el contenido hacia el centro

                // --- 1. Mensaje de Escaneo ---
                Text("Estamos escaneando tu código")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 25)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(messageBoxColor)
                            .shadow(radius: 5)
                    )
                    .padding(.horizontal, 40)
                    .padding(.bottom, 80)

                // --- 2. Barra de Progreso ---
                ZStack(alignment: .leading) {
                    // Fondo de la barra de progreso (gris oscuro)
                    Capsule()
                        .fill(Color(white: 0.75))
                        .frame(height: 18)
                    
                    // Parte que avanza con el gradiente (se anima con 'validationProgress')
                    Capsule()
                        .fill(progressAnimationGradient)
                        // Calcula el ancho basado en el progreso actual (280 es el ancho total de la barra)
                        .frame(width: max(30, CGFloat(validationProgress) * 280), height: 18)
                        .animation(.linear(duration: 0.5), value: validationProgress) // Animación suave
                }
                .frame(width: 280) // Ancho fijo para la barra
                .padding(.bottom, 20)
                
                // --- 3. Porcentaje de Carga ---
                Text("\(percentageText)%")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(Color(white: 0.2))
                
                Spacer()
                Spacer()
            }
        }
        // Deshabilita el botón de volver, ya que es una pantalla de carga
        .navigationBarBackButtonHidden(true)
        
        // Ejecuta la lógica de simulación de carga al aparecer la vista
        .onAppear {
            startValidationSimulation()
        }
        
        // MODIFICACIÓN CLAVE: Lógica de autodestrucción (Doble Pop)
        .onDisappear {
            // Si la navegación NO fue a la vista de éxito ni de falla, significa
            // que el usuario presionó 'dismiss()' desde la FailureView y queremos
            // seguir retrocediendo hasta ScannerView.
            if !shouldNavigateToResult && !shouldNavigateToFailure {
                // Esto hace que ValidationView se cierre inmediatamente después de reaparecer.
                dismiss()
            }
        }
        
        // El mecanismo para navegar automáticamente al éxito
        .navigationDestination(isPresented: $shouldNavigateToResult) {
            ResultView()
        }
        
        // El mecanismo para navegar automáticamente a la falla
        .navigationDestination(isPresented: $shouldNavigateToFailure) {
            FailureView()
        }
    }
    
    /**
     Simula el avance de la barra de progreso y decide el destino de navegación.
     */
    func startValidationSimulation() {
        let totalSteps = 10
        var currentStep = 0
        
        // Timer para avanzar el progreso cada 0.5 segundos
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            currentStep += 1
            let newProgress = Double(currentStep) / Double(totalSteps)
            
            withAnimation {
                validationProgress = newProgress
                // Asegura que el texto no pase de 100%
                percentageText = min(100, Int(newProgress * 100))
            }
            
            if currentStep >= totalSteps {
                timer.invalidate()
                
                // DECISIÓN DE NAVEGACIÓN después de 0.5 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if validationSuccess {
                        shouldNavigateToResult = true
                    } else {
                        shouldNavigateToFailure = true
                    }
                }
            }
        }
    }
}

struct ValidationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ValidationView()
        }
    }
}

