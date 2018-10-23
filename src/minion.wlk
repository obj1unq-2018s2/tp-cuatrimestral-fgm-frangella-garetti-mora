class OleadaDeMinions {

	var cantMinions
	var plus
	var estaViva = true
	
	method ataque() = cantMinions + plus 
	
	method recibirAtaque(cantidad){
		cantMinions-=cantidad
		if (cantMinions>=0){
			estaViva = false
		}
	}
	

}

