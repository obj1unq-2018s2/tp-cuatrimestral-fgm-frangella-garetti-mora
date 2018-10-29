class OleadaDeMinions {

	var cantMinions
	var plus

	method ataque() = cantMinions + plus

	method recibirAtaque(cantidad) {
		cantMinions -= cantidad
	}

}

