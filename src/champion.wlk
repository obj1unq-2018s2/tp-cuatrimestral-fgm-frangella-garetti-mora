class Champion {

	const property vidaBase // Correccion etapa 1
	const property ataqueBase // Correccion etapa 1
	var property danio = 0
	var bloqueos = 0
	var property items = []
	var property dinero

	constructor(_vida, _ataque) {
		vidaBase = _vida
		ataqueBase = _ataque
	}

	method estaVivo() = danio < vidaBase

	method vida() = vidaBase + items.sum{ item => item.puntosDeVida(self) }

	method ataque() = ataqueBase + items.sum{ item => item.puntosDeAtaque(self) }

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
		if (bloqueos < 1) {
			self.recibirDanio(cantidad)
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

	method quitarDanio(cantidad) { // Correccion etapa 1
		if (cantidad > danio) {
			danio = 0
		} else {
			danio -= cantidad
		}
	}

	method comprar(item){
		if (dinero>=item.costo()){
			self.equiparItem(item)
			self.quitarDinero(item.costo())
		}
	}
	
	method vender(item){
		self.desequiparItem(item)
		self.ganarDinero(item.costo()/2)
	}
	
	method ganarDinero(cantidad){
		dinero+=cantidad
	}
	
	method quitarDinero(cantidad){
		dinero-=cantidad
	}
}

