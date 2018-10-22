class OleadaDeMinions {

	var cantMinions
	var plus
	var estaViva = true
	
	method ataque() = cantMinions + plus 
	method recibirAtaque(alguien){
		cantMinions-=alguien.ataque()
		if (cantMinions>=0){
			estaViva = false
		}
	}
	

}

