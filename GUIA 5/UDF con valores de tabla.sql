-- UDF con valores de tabla

create or alter function EmpleadosLista(@fechaContratacion date)
returns table
	as
	return
		select * from Empleados
		where fechaContratacion > @fechaContratacion;