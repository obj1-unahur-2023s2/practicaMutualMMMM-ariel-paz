class Actividad{
	method esfuerzo()
	method broncearse()
	method dias()
	method esRecomendada(soc)
}
class Viaje inherits Actividad{
	const property idiomas = #{}
	method esInteresante() = not idiomas.isEmpty()
	override method esRecomendada(soc) = self.esInteresante() and soc.leAtrae(self) and not soc.actividades().contains(self)
}

class Playa inherits Viaje{
	const largo
	override method dias() = largo /500
	override method esfuerzo() = largo > 1200
	override method broncearse() = true
}

class Ciudad inherits Viaje{
	const atracciones
	override method dias() = atracciones.size()/2
	override method esfuerzo() = atracciones.between(5,8)
	override method broncearse() = false
	override method esInteresante() = super() or atracciones.size() == 5
}

class Tropi inherits Ciudad{
	override method dias() = super() + 1
	override method broncearse() = true
}

class Trekking inherits Viaje{
	const senderos
	const diaSol
	override method dias() = senderos / 50
	override method esfuerzo() = senderos > 80
	override method broncearse() = diaSol > 200 or (diaSol > 100 and diaSol < 200 and senderos>120)
	override method esInteresante() = super() and diaSol > 140
}

class Gim inherits Actividad{
	method idiomas() = #{"esp"}
	override method dias() = 1
	override method esfuerzo() = true
	override method broncearse() = false
	override method esRecomendada(soc) = soc.edad() >20 and soc.edad()<30
}

class Socio{
	const edad
	const idiomas=#{}
	const actividades= #{}
	const maxAct
	method agregarActividad(act){
		if (self.puedeAgregarAct()){
			actividades.add(act)
		}
	}
	method puedeAgregarAct() = actividades.size() < maxAct
	method adorador() = actividades.all({act=>act.broncearse()})
	method forzada() = actividades.map({act=>act.esfuerzo()})
	method leAtrae(act)
}
class Tranquilo inherits Socio{
	override method leAtrae(act) = act.dias() >= 4
}
class Coherente inherits Socio{
	override method leAtrae(act) = self.adorador() and act.broncearse() or act.esfuerzo()
}
class Relajado inherits Socio{
	override method leAtrae(act) = act.idiomas().any({i =>idiomas.includes(i)})
}