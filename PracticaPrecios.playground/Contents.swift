import UIKit
import Combine


@MainActor
class FiltroPreciosViewModel: ObservableObject {
    
    @Published var precio: Double = 0.0
    @Published var precioFormateado: String =  "Sin Preecio"

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        actualizarPrecioFormateado()
    }
    
    private func actualizarPrecioFormateado() {
        $precio
            .dropFirst() // Ignora el valor inicial al arrancar
            .filter { valor in valor > 0}
            .map { valor in
                "Precio: Q. \(valor) "
            }
            .assign(to: &$precioFormateado)
    }

}


let precios = FiltroPreciosViewModel()

let subscribe = precios.$precioFormateado.sink { valor in
//    print(valor)
}

precios.precio = 100.12
precios.precio = 200.60
precios.precio = -9

