import Foundation
import Combine

@MainActor
class CarritoViewModel {
    // Inputs (Lo que cambia desde la pantalla)
    @Published var cantidadArticulos: Int = 1
    
    // Outputs (Lo que escucha la pantalla para actualizarse)
    @Published var estaCargando: Bool = false
    @Published var mensajeServidor: String = "Carrito listo"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupCarritoPipeline()
    }
    
    private func setupCarritoPipeline() {
        // 1. Primer Flujo: En cuanto la cantidad cambia, activamos el "Cargando" de inmediato
        $cantidadArticulos
            .dropFirst() // Ignora el valor inicial al arrancar
            .map { _ in true }
            .assign(to: \.estaCargando, on: self)
            .store(in: &cancellables)
        
        // 2. Segundo Flujo: Espera a que el usuario se detenga para simular el envío al servidor
        $cantidadArticulos
            .dropFirst()
            // Espera 500 milisegundos de calma antes de continuar
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { cantidad in
                // Simulamos la respuesta que regresaría el servidor
                return "Servidor: Carrito actualizado con \(cantidad) artículos con éxito."
            }
            .receive(on: DispatchQueue.main)
            .sink { respuesta in
                self.mensajeServidor = respuesta
                self.estaCargando = false // Apagamos el estado de carga
            }
            .store(in: &cancellables)
    }
}

let viewModel = CarritoViewModel()

let subCarga = viewModel.$estaCargando.sink { cargando in
    print("¿Mostrando Spinner de Carga?: \(cargando ? "SÍ ⏳" : "NO ⚪")")
}

let subMensaje = viewModel.$mensajeServidor.sink { mensaje in
    print("Estatus: \(mensaje)\n")
}

print("--- El usuario empieza a presionar el botón '+' rápidamente ---")

// Simulación: El usuario da 4 clics seguidos
viewModel.cantidadArticulos = 2
viewModel.cantidadArticulos = 3
viewModel.cantidadArticulos = 4
viewModel.cantidadArticulos = 8
