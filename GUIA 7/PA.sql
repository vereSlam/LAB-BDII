--Guia 7: Triggers
--use SuperMercado;

-- Procedimiento almacenado para agregar clientes
create procedure AgregarClientes
    @nombresCliente varchar(150),
    @apellidosCliente varchar(150),
    @telefono varchar(9),
    @email varchar(255),
    @DUI varchar(13),
    @idDireccion int
as
begin	
	insert into Clientes (nombresCliente, apellidosCliente, telefono, email, DUI, idDireccion) 
	values (@nombresCliente, @apellidosCliente, @telefono, @email, @DUI, @idDireccion)
end;