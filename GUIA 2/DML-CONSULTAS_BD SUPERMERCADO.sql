-- OPERADORES LÓGICOS O ARIMÉTICOS

-- Mostrar los Productos que sean diferentes a la SubCategorias de lácteos y limpieza
	select idProducto, nombreProducto, precioUnitario
	from Productos
	where idSubCategoria != 3 and idSubCategoria!= 11;

-- Mostrar los datos de la tabla CantidadStock donde la cantidad sea mayor a 260 o menor a 200
	select idCantidadStock, Cantidad, FechaEntrada
	from CantidadStock
	where cantidad > 260
	or Cantidad < 200;

-- Mostrar los clientes donde su primer nombre empiece por C o L y que su apellido termine en Z
	select idCliente, concat(nombresCliente,' ',apellidosCliente) as NombreCompleto, telefono 
	from Clientes
	where nombresCliente like 'c%' or nombresCliente like'l%'
	and apellidosCliente like'%z';

-- CÁLCULOS ARITMÉTICOS

-- Mostrar el total de las primeras dos compras
	select sum(MontoTotal) as Total
	from Compras
	where idCompra = 1
	or idCompra = 2;

-- OBTENCIÓN DE DATOS DEL SISTEMA

-- Mostrar los empleados que tienen 3 años o menos trabajando

	select idEmpleado, concat(nombresEmpleado, apellidosEmpleado) as Nombre, datediff(month, fechaContratacion, getdate()) as TiempoLaborando
	from Empleados
	where datediff(month, fechaContratacion, getdate()) <= 36;

-- MULTITABLA

-- mostrar el cargo de cada empleado
	select e.idEmpleado, concat(e.nombresEmpleado,' ',e.apellidosEmpleado) as Nombre, e.idCargo, c.cargo
	from empleados e, cargos c
	where e.idCargo = c.idCargo;

-- Mostrar la unidad de precio y la categoria de los productos
	select p.idProducto, p.nombreProducto, up.unidadPrecio, sc.subCategoria, c.categoria
	from Productos p, unidadPrecio up, SubCategorias sc, Categorias c
	where p.idUnidadPrecio = up.idUnidadPrecio
	and p.idSubCategoria = sc.idSubCategoria
	and sc.idCategoria = c.idCategoria;

-- Mostrar el Precio final(con descuento) menores a 5 dólares 
	select p.idProducto, p.nombreProducto, d.nombreDescuento, p.precioUnitario as precioInicial, d.porcentajeDescuento, round(p.precioUnitario-(d.porcentajeDescuento*p.precioUnitario/100),2) as PrecioFinal
	from Descuentos d, Productos p, AsignacionDescuentoProducto ad 
	where  p.idProducto = ad.idProducto and d.idDescuento = ad.idDescuento
	and round(p.precioUnitario-(d.porcentajeDescuento*p.precioUnitario/100),2) < 5;

-- SUBCONSULTA

-- Mostrar los productos con su porcentaje de descuento
	select ad.idProducto, 
	(select p.nombreProducto from Productos p where p.idProducto = ad.idProducto) as NombreProducto, ad.idDescuento,
	(select d.porcentajeDescuento from Descuentos d where d.idDescuento = ad.idDescuento) as Descuento
	from AsignacionDescuentoProducto ad;

-- Mostrar la factura de las ventas del mes de agosto del día 17 en adelante, el monto total, el producto que se vendió y quien lo vendió
	select v.idVenta, v.fechaVenta, dv.montoTotal,
	(select p.nombreProducto from Productos p where p.idProducto = dv.idProducto) as Productos,
	(select concat(e.nombresEmpleado,' ',e.apellidosEmpleado) from Empleados e where e.idEmpleado = v.idEmpleado) as Empleado
	from Ventas v, DetallesVentas dv
	where dv.idVenta = v.idVenta
	and month(v.fechaVenta) = 08 and day(v.fechaVenta) >=17;

-- JOINS

-- Mostrar las compras que se hicieron en el mes de abril y mayo, mostrar el proveedor y el empleado encargado de dicha compra
	select c.IdCompra, c.FechaCompra, p.nombreProveedor, e.nombresEmpleado as EncargadoCompra
	from compras c
	inner join Proveedores p on c.idProveedor = p.idProveedor 
	inner join Empleados e on c.IdEmpleado = e.idEmpleado
	where month(c.FechaCompra)= 04
	or month(c.FechaCompra)= 05;



