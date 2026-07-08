import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Perfil {
    let nombre: String
    let email: String
}

enum RedError: Error {
    case conexionInestable
}

@MainActor
class ProfileViewModel: ObservableObject {
    
    // 1. El ID se queda fijo, ya no maneja el flujo de recarga
    var usuarioId: Int = 101
    @Published var nombrePantalla: String = "Cargando..."
    
    // 2. DISPARADOR REAL: Un canal vacío que solo transmite el evento "Recargar"
    let botonRecargarTrigger = PassthroughSubject<Void, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    var simuladordefallos = 0
    
    init() {
//        setupPerfileProfile()
    }
    
    private func setupPerfileProfile() {
        // 3. El pipeline ahora escucha al BOTÓN, no al ID
        botonRecargarTrigger
            .flatMap { [weak self] _ -> AnyPublisher<Perfil, Never> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                
                // Llamamos a la red usando el ID fijo actual
                return self.getInfoProfile(id: self.usuarioId)
                    .retry(2)
                    // Importante: El catch lo movemos ADENTRO para que el botón
                    // no se rompa si los reintentos fallan por completo
                    .catch { _ in Just(Perfil(nombre: "Usuario Offline ⚠️", email: "none")) }
                    .eraseToAnyPublisher()
            }
            .map { perfil in perfil.nombre }
            .assign(to: &$nombrePantalla)
    }
    
    private func getInfoProfile(id: Int) -> AnyPublisher<Perfil, RedError> {
        simuladordefallos += 1
        let intentoActual = simuladordefallos
        
        if intentoActual <= 2 {
            return Fail(error: RedError.conexionInestable)
                .delay(for: .milliseconds(500), scheduler: RunLoop.main)
                .handleEvents(receiveSubscription: { _ in
                    print("🌐 [Servidor] Intento \(intentoActual): Error de red detectado...")
                })
                .eraseToAnyPublisher()
        }
        
        return Just(Perfil(nombre: "Ariel Ramirez", email: "ariel12jona@gmail.com"))
            .delay(for: .milliseconds(500), scheduler: RunLoop.main)
            .handleEvents(receiveSubscription: { _ in
                print("🌐 [Servidor] Intento \(intentoActual): ¡Conexión exitosa!")
            })
            .setFailureType(to: RedError.self)
            .eraseToAnyPublisher()
    }
}

// === ÁREA DE PRUEBAS (Simulación de la Pantalla) ===
let viewModel = ProfileViewModel()

//let subcripcion = viewModel.$nombrePantalla.sink { print("📺 Pantalla muestra: \($0)\n") }
//
//print("--- El usuario entra a la pantalla y presiona 'Recargar' ---")
// Mandamos la señal de que el botón fue pulsado
viewModel.botonRecargarTrigger.send()
