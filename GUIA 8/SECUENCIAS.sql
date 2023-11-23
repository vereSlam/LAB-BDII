-- TABLA CLIENTELOG

create sequence logId
	start with 1
	increment by 2
	minvalue 1
	maxvalue 99999999

-- Tabla ClienteLog con el campo logId sin identity
create table ClienteLog(
	logId int DEFAULT next value for dbo.logId primary key,
	clienteId int not null,
	operacion nvarchar(10) not null,
	fechaActualizacion datetime not null
)

-- Trigger con PA de la guia 7
exec AgregarClientes 
    @nombresCliente = 'Paola Esmeralda',
    @apellidosCliente = 'Sanchez Perez',
    @telefono = '61244678',
    @email = 'paolaSanchez@gmail.com',
    @DUI = '64567911-3',
    @idDireccion = '6'

select * from ClienteLog
