-- OPERADORES LÓGICOS O ARIMÉTICOS

-- Mostrar los Productos que sean diferentes a la categorias de electronica y ropa
	select idProducto, nombreProducto, precioUnitario
	from Productos
	where idCategoria != 1 and idCategoria!= 2;

-- Mostrar los datos de la tabla CantidadStock donde la cantidad sea mayor a 260 o menor a 200
	select idCantidadStock, Cantidad, FechaEntrada
	from CantidadStock
	where cantidad > 260
	or Cantidad < 200;

-- Mostrar los clientes donde su nombre empiece por M o P y que su apellido termine en Z
	select idCliente, concat(nombresCliente,' ',apellidosCliente) as Nombre, telefono 
	from Clientes
	where nombresCliente like 'm%' or nombresCliente like'p%'
	and apellidosCliente like'%z';

-- CÁLCULOS ARITMÉTICOS

-- Mostrar el total del monto total de las primeras dos facturas de compras
	select sum(MontoTotal) as Total
	from FacturaCompras
	where IdFactCompra = 1
	or IdFactCompra = 2;

-- OBTENCIÓN DE DATOS DEL SISTEMA

-- Mostrar los empleados que tienen 18 meses o más trabajando

	select idEmpleado, concat(nombresEmpleado, apellidosEmpleado) as Nombre, datediff(month, fechaContratacion, getdate()) as TiempoLaborando
	from Empleados
	where datediff(month, fechaContratacion, getdate()) >= 18;

-- MULTITABLA

-- mostrar el cargo de cada empleado
	select e.idEmpleado, concat(e.nombresEmpleado,' ',e.apellidosEmpleado) as Nombre, e.idCargo, c.cargo
	from empleados e, cargos c
	where e.idCargo = c.idCargo;

-- Mostrar la unida de precio y la categoria de los productos
	select p.idProducto, p.nombreProducto, up.unidadPrecio, c.categoria
	from Productos p, unidadPrecio up, Categorias c
	where p.idUnidadPrecio = up.idUnidadPrecio
	and p.idCategoria = c.idCategoria;

-- Mostrar el Precio final(con descuento) menores a 20 dólares 
	select p.idProducto, p.nombreProducto, d.nombreDescuento, p.precioUnitario as precioInicial, d.porcentajeDescuento, round(p.precioUnitario-(d.porcentajeDescuento*p.precioUnitario/100),2) as PrecioFinal
	from Descuentos d, Productos p, AsignacionDescuentoProducto ad 
	where  p.idProducto = ad.idProducto and d.idDescuento = ad.idDescuento
	and round(p.precioUnitario-(d.porcentajeDescuento*p.precioUnitario/100),2) < 20;

-- SUBCONSULTA

-- Mostrar los productos con su porcentaje de descuento
	select ad.idProducto, 
	(select p.nombreProducto from Productos p where p.idProducto = ad.idProducto) as NombreProducto, ad.idDescuento,
	(select d.porcentajeDescuento from Descuentos d where d.idDescuento = ad.idDescuento) as Descuento
	from AsignacionDescuentoProducto ad;

-- Mostrar la factura de las ventas del mes de agosto del día 17 en adelante, el total de venta, el producto que se vendió y quien lo vendió
	select fv.idFactVenta, fv.fechaVenta, fv.totalVenta, 
	(select p.nombreProducto from Productos p where p.idProducto = fv.idProducto) as Productos,
	(select concat(e.nombresEmpleado,' ',e.apellidosEmpleado) from Empleados e where e.idEmpleado = fv.idEmpleado) as Empleado
	from FacturaVentas fv
	where month(fv.fechaVenta) = 08
	and day(fv.fechaVenta) >=17;

-- JOINS

-- Mostrar las compras que se hicieron en el mes de abril y mayo, mostrar el proveedor y el empleado encargado de dicha compra
	select c.IdCompra, c.ProductosComprados, c.FechaCompra, p.nombreProveedor, e.nombresEmpleado as EncargadoCompra
	from compras c
	inner join Proveedores p on c.idProveedor = p.idProveedor 
	inner join Empleados e on c.IdEmpleado = e.idEmpleado
	where month(c.FechaCompra)= 04
	or month(c.FechaCompra)= 05;



