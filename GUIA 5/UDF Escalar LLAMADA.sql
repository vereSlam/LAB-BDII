-- FORMA 1
select dbo.CalcularMontoTotalVenta(3);

-- FORMA 2 con actualizacion de datos en la tabla
declare @idVenta int = 1
declare @MontoTotal float

	-- Obtener el monto total llamando a la función
select @MontoTotal = dbo.CalcularMontoTotalVenta(@idVenta)

	-- Actualizar la tabla de DetallesVentas con el nuevo montoTotal
update DetallesVentas
set montoTotal = @MontoTotal
where idDetallesVenta = @idVenta

	-- Se imprime los resultados
select 'Monto actualizado: ' + cast(@MontoTotal as varchar(10)) as montoTotal
