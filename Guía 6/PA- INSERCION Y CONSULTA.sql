-- INSERCION
create procedure AgregarCliente
	@nombresCliente varchar(150),
	@apellidosCliente varchar(150),
	@telefono varchar(9),
	@email varchar(255), 
	@DUI varchar (13),
	@idDireccion int
as
	begin
		insert into Clientes values
		(
		@nombresCliente,
		@apellidosCliente,
		@telefono,
		@email, 
		@DUI,
		@idDireccion
		);
		select * from Clientes;
	end;

execute AgregarCliente
		@nombresCliente = 'Maria Jose',
		@apellidosCliente = 'Lopez Martinez',
		@telefono = '61079498',
		@email = 'mariajose@gmail.com', 
		@DUI = '31445675-6',
		@idDireccion = '1';

-- CONSULTA
create procedure MostrarCategoria
as
	begin
		select p.idProducto, p.nombreProducto, up.unidadPrecio, c.categoria
		from Productos p, unidadPrecio up, Categorias c, SubCategorias sc
		where p.idUnidadPrecio = up.idUnidadPrecio
		and p.idSubCategoria = sc.idSubCategoria
		and sc.idCategoria = c.idCategoria;
	end;

exec MostrarCategoria;

