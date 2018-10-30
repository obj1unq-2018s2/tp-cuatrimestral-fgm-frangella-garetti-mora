class Champion {

	const property vidaBase // Correccion etapa 1
	const property ataqueBase // Correccion etapa 1
	var property danio = 0
	var bloqueos = 0
	var items = []
	var property dinero

	constructor(_vida, _ataque, _dinero) {
		vidaBase = _vida
		ataqueBase = _ataque
		dinero = _dinero
	}

	method estaVivo() = danio < vidaBase

	method items() = items

	method tieneItem(item) = items.contains(item)

	method vida() = vidaBase + self.items().sum{ item => item.puntosDeVida(self) }

	method ataque() = ataqueBase + self.items().sum{ item => item.puntosDeAtaque(self) }

	method bloqueos() = bloqueos

	method sumarBloqueos(cantidad) {
		bloqueos += cantidad
	}

	method atacar(alguien) {
		var ataqueEnemigo = alguien.ataque() // variables locales para que el danio no se modifique por quien pega primero
		var ataquePropio = self.ataque()
		self.recibirAtaque(ataqueEnemigo)
		alguien.recibirAtaque(ataquePropio)
		self.ganarDinero(alguien.dineroQueEntrega())
	}

	method recibirAtaque(cantidad) {
		if (bloqueos < 1 && cantidad > 0) {
			self.recibirDanio(cantidad)
		} else if (bloqueos >= 1 && cantidad > 0) {
			bloqueos -= 1
		}
	}

	method equiparItem(item) {
		items.add(item)
		item.efectoAlEquipar(self)
	}

	method desequiparItem(item) {
		items.remove(item)
		item.efectoAlDesequipar(self)
	}

	method recibirDanio(cantidad) {
		danio += cantidad
	}

	method quitarDanio(cantidad) { // Correccion etapa 1
		if (cantidad > danio) {
			danio = 0
		} else {
			danio -= cantidad
		}
	}

	method comprar(item) {
		if (dinero >= item.costo()) {
			self.equiparItem(item)
			self.quitarDinero(item.costo())
		}
	}

	method vender(item) {
		self.desequiparItem(item)
		self.ganarDinero(item.costo() / 2)
	}

	method ganarDinero(cantidad) {
		dinero += cantidad
	}

	method quitarDinero(cantidad) {
		dinero -= cantidad
	}

}

class Support inherits Champion {

	var property vinculo // campeon

	override method atacar(alguien) {
		super(alguien)
		vinculo.quitarDanio(10)
	}

	method itemsVinculo() = vinculo.items()

	method vincular(campeon) {
		vinculo = campeon
	}

	override method items() = super() + vinculo.items()

}

