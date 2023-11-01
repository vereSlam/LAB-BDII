-- Guia 7: Triggers
--use SuperMercado;

-- Nueva tabla 
create table ClienteLog(
	logId int identity(1,1) not null,
	clienteId int not null,
	operacion nvarchar(10) not null,
	fechaActualizacion datetime not null
)

-- Trigger para insertar el evento en la tabla clienteLog
create or alter trigger trgInsertarClienteLog
on Clientes
after insert
as
begin
	declare @idCliente int;
    declare @nombresCliente varchar(150);
    declare @apellidosCliente varchar(150);
    declare @telefono varchar(9);
    declare @email varchar(255);
    declare @DUI varchar(13);
    declare @idDireccion int
	declare @logId int;
	declare @clienteId int;
	declare @operacion nvarchar(10);
	declare @fechaActualizacion datetime;
	
    select  
	@idCliente = idCliente,
    @nombresCliente = nombresCliente,
    @apellidosCliente = apellidosCliente,
    @telefono = telefono,
    @email = email,
    @DUI = DUI,
    @idDireccion = idDireccion
	from inserted

	insert into ClienteLog(clienteId,Operacion,FechaActualizacion)
	select @idCliente, 'INSERTAR', GETDATE() 
	from inserted;

	print 'Se realizó un nuevo registro en la tabla de Clientes'
end;

-- Consultas
select * from Clientes;
select * from ClienteLog;

-- Evento que activa el trigger
exec AgregarClientes 
    @nombresCliente = 'Fatima Esmeralda',
    @apellidosCliente = 'Diaz Perez',
    @telefono = '61244678',
    @email = 'fatimadiaz@gmail.com',
    @DUI = '64567911-3',
    @idDireccion = '5'

