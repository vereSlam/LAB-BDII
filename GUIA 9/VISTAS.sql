-- DIRECCIONES
create view VistaDireccionCompleta as
select d.idDireccion, d.linea1, d.linea2, d.idDistrito, di.distrito, 
	   m.municipio, dep.departamento, dep.pais, d.codigoPostal
from Direcciones d
inner join Distritos di on d.idDistrito = di.idDistrito
inner join Municipios m on di.idMunicipio = m.idMunicipio
inner join Departamentos dep on m.idDepartamento = dep.idDepartamento

select * from VistaDireccionCompleta;
select * from Direcciones;

-- EMPLEADOS
create view VistaEmpleados as
select e.idEmpleado, e.nombresEmpleado, e.apellidosEmpleado, e.DUI, e.ISSS, 
	   e.telefono, e.email, e.fechaNac, e.fechaContratacion, e.salario,
	   e.idCargo, c.cargo, e.idDireccion, 
	   d.Linea1 + ', ' + d.Linea2 + ', ' +
	   d.Distrito + ', ' + d.Municipio + ', ' +
	   d.Departamento + ', ' + d.Pais + ', ' +
	   CAST(d.CodigoPostal as char(5)) as direccionCompleta
from Empleados e
inner join Cargos c on e.idCargo = c.idCargo
inner join VistaDireccionCompleta d on e.idDireccion = d.idDireccion;