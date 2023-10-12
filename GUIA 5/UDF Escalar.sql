-- UDF Escalar
-- Función escalar llamada CalcularMontoTotalVenta
create or alter function CalcularMontoTotalVenta(@idVenta int)
returns float
as
begin
	-- Variables
    declare @MontoTotal float

    select @MontoTotal =  p.precioUnitario * dv.cantidadVendida
    from DetallesVentas dv, Productos p, Ventas v
	where dv.idVenta = v.idVenta
	and dv.idProducto = p.idProducto
    and v.idVenta = @idVenta

    return @MontoTotal
end
