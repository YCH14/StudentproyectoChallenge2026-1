//
//  CameraView.swift
//  appmundo
//
//  Created by Yaretzi Calzontzi Hernández on 15/10/25.
//


//
//  CameraView.swift
//  appMundial
//
//  Created by Yaretzi Calzontzi Hernández on 10/10/25.
//

import SwiftUI
import AVFoundation

// 1. Definición del Wrapper para la Cámara (UIViewRepresentable)
struct CameraView: UIViewRepresentable {
    
    // MODIFICACIÓN CLAVE: Añadir el binding para comunicar la detección a ScannerView
    @Binding var isCodeDetected: Bool
    
    // El 'session' debe ser una propiedad de la vista (no estática)
    var session = AVCaptureSession()

    // Crea el view de UIKit que albergará la cámara
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        // Solicitar permisos de cámara
        AVCaptureDevice.requestAccess(for: .video) { success in
            if success {
                DispatchQueue.main.async {
                    self.setupCameraSession(for: view)
                }
            } else {
                print("Acceso a la cámara denegado.")
            }
        }
        return view
    }

    // Actualiza la vista de UIKit (no es necesario para un simple video feed)
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    // Configura la sesión de captura de video
    private func setupCameraSession(for view: UIView) {
        // 1. Configurar entrada (Input)
        guard let camera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: camera) else {
            return
        }
        
        // 2. Configurar salida (Output)
        // **Para la funcionalidad REAL de tu app (en el futuro):**
        // Aquí agregarías AVCaptureMetadataOutput para escanear QR/códigos de barras,
        // y usarías un delegado para actualizar self.isCodeDetected = true
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        // 3. Configurar la capa de previsualización (Preview Layer)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(previewLayer)
        
        // 4. Iniciar la sesión
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    // Detener la sesión cuando la vista desaparece (buena práctica de memoria)
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        // Detener la sesión de captura cuando la vista se elimina
        if let session = (uiView.layer.sublayers?.first as? AVCaptureVideoPreviewLayer)?.session {
            session.stopRunning()
        }
    }
}
