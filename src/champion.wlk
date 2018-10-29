class Champion {

	const vidaBase
	const ataqueBase
	var property danio = 0
	var bloqueos = 0
	var property items = []

	constructor(_vida, _ataque) {
		vidaBase = _vida
		ataqueBase = _ataque
	}

	method estaVivo() = danio < vidaBase

	method vida() = vidaBase + items.sum{ item => item.puntosDeVida(self) }

	method ataque() = ataqueBase + items.sum{ item => item.puntosDeAtaque(self) }

	method bloqueos() = bloqueos

	method bloqueos(cantidad) {
		bloqueos += cantidad
	}

	method atacar(alguien) {
		self.recibirAtaque(alguien)
		alguien.recibirAtaque(self.ataque())
	}

	method recibirAtaque(alguien) {
		if (bloqueos < 1) {
			self.recibirDanio(alguien.ataque())
		} else {
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

	method quitarDanio(cantidad) {
		danio -= cantidad
	}

}

