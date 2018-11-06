class Item {

	method costo()

	method efectoAlActivar(champion)

	method puntosDeVida(champion)

	method puntosDeAtaque(champion)

	method efectoAlEquipar(champion)

	method efectoAlDesequipar(champion)

}

class ItemActivable inherits Item {

	var cantUsos = 0

	method cantUsos() = cantUsos

	method limiteDeUsos()

	method gastarUso() {
		cantUsos += 1
	}

	method tieneUsoDisponible() = self.cantUsos() < self.limiteDeUsos()

	method puedeActivar(champion) = self.tieneUsoDisponible()

}

class AnilloDeDoran inherits Item {

	override method costo() = 300

	override method efectoAlActivar(champion) {
	}

	override method puntosDeVida(champion) = 60

	override method puntosDeAtaque(champion) = 15

	override method efectoAlEquipar(champion) {
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {
		champion.quitarDanio(10)
	}

}

class TomoAmplificador inherits ItemActivable {

	override method puedeActivar(champion) = super(champion) && champion.dinero() < self.dineroEfecto()

	override method limiteDeUsos() = 1

	method dineroEfecto() = 500

	override method costo() = 500

	override method efectoAlActivar(champion) {
		// if (self.tieneUsoDisponible() and champion.dinero() < self.dineroEfecto()){
		if (self.puedeActivar(champion)) {
			champion.dinero(self.dineroEfecto())
			self.gastarUso()
		}
	}

	override method puntosDeVida(champion) = champion.danio() * 0.25 // Correccion etapa 1

	override method puntosDeAtaque(champion) = champion.danio() * 0.05 // Correccion etapa 1

	override method efectoAlEquipar(champion) {
		champion.sumarBloqueos(2)
	}

	override method efectoAlDesequipar(champion) {
		champion.sumarBloqueos(1)
		champion.recibirDanio(30)
	}

}

class SombreroDeRabadon inherits TomoAmplificador {

	override method costo() = super() + 100

	override method puntosDeVida(champion) = super(champion) + 5

	override method puntosDeAtaque(champion) = champion.ataqueBase() * 2

	override method efectoAlEquipar(champion) {
		super(champion)
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {
	}

}

class PocionDeVida inherits ItemActivable {

	override method limiteDeUsos() = 2

	override method costo() = 50

	override method efectoAlActivar(champion) {
		if (self.puedeActivar(champion)) {
			champion.quitarDanio(50)
			self.gastarUso()
		}
	}

	override method puntosDeVida(champion) = 0

	override method puntosDeAtaque(champion) = 0

	override method efectoAlEquipar(champion) {
	}

	override method efectoAlDesequipar(champion) {
	}

}

class BastonDelVacio inherits ItemActivable {

	var property items = []

	override method limiteDeUsos() {
	}

	method agregarMaterial(item) {
		items.add(item)
	}

	method quitarMaterial(item) {
		items.remove(item)
	}

	override method costo() = 0

	override method efectoAlActivar(champion) {
		items.forEach{ item => item.efectoAlActivar(champion)}
	}

	override method puntosDeVida(champion) = items.sum{ item => item.puntosDeVida(champion) / 2 }

	override method puntosDeAtaque(champion) = items.sum{ item => item.puntosDeAtaque(champion) }

	override method efectoAlEquipar(champion) {
	}

	override method efectoAlDesequipar(champion) {
	}

}

