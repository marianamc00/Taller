{2.- Implementar un programa que procese información de propiedades que están a la venta
en una inmobiliaria.
Se pide:
a) Implementar un módulo para almacenar en una estructura adecuada, las propiedades
agrupadas por zona. Las propiedades de una misma zona deben quedar almacenadas
ordenadas por tipo de propiedad. Para cada propiedad debe almacenarse el código, el tipo de
propiedad y el precio total. De cada propiedad se lee: zona (1 a 5), código de propiedad, tipo
de propiedad, cantidad de metros cuadrados y precio del metro cuadrado. La lectura finaliza
cuando se ingresa el precio del metro cuadrado -1.
b) Implementar un módulo que reciba la estructura generada en a), un número de zona y un tipo de
propiedad y retorne los códigos de las propiedades de la zona recibida y del tipo recibido. }

program ejercicio2;

const
 max = 5;

type
 rango_zona = 1..max;
 str20 = string[20];

 pleida = record
  zona : rango_zona;
  cod : integer;
  tipo : str20;
  cm2, pm2 : real;
 end;

 propiedad = record
  cod : integer;
  tipo : str20;
  precio : real;
 end;

 lista = ^nodo;
 nodo = record
  dato : propiedad;
  sig : lista;
 end;

 vector = array [rango_zona] of lista;
 
 procedure leoDatos (var p : pleida);
 begin
   write ('Precio por metro cuadrado: '); readln (p.pm2);
   if (p.pm2 <> -1) then begin
    write ('Cantidad de metros cuadrados: '); readln (p.cm2);
    write ('Codigo: '); readln (p.cod);
    write ('Tipo: '); readln (p.tipo);
    write ('Zona: '); readln (p.zona);
    writeln ('-----------------------------');
   end;
 end;
 
 procedure cargoLista (p : propiedad; var l,l2 : lista);
 var
  nue, ant, act : lista;
 begin
  new (nue);
  nue^.dato := p; nue^.sig := nil;
  l2 := nue;
  if (l = nil) then
   l := nue
  else begin
   ant := l; act := l;
   while (act <> nil) and (act^.dato.tipo < nue^.dato.tipo) do begin
    ant := act;
    act := act^.sig
   end;
   if (l = act) then begin
    nue^.sig := l;
    l := nue
   end
   else begin
    ant^.sig := nue;
    nue^.sig := act;
   end;
  end;
 end;
 
 procedure cargoDatos (p : pleida; var l,l2 : lista; var v : vector);
 var
  prop : propiedad;
 begin
  prop.cod := p.cod;
  prop.tipo := p.tipo;
  prop.precio := p.cm2 * p.pm2;
  cargoLista (prop,l,l2);
  v[p.zona] := l2
 end; 
 
 procedure retornoPropiedades (v : vector; nz : rango_zona; tp : str20);
 begin
  writeln ('Propiedades que coinciden: ');
  while (v[nz] <> nil) do begin
   if (v[nz]^.dato.tipo = tp) then
    writeln ('Codigo ' , v[nz]^.dato.cod);
   v[nz]:= v[nz]^.sig;
  end;
 end;
 
 procedure inicializoVector (var v : vector);
 var
  i : rango_zona;
 begin
  for i := 1 to 5 do
   v[i] := nil;
 end;
 
// programa ppl
var
 l,l2 : lista;
 p : pleida;
 nz : rango_zona;
 tp : str20;
 v : vector;
 
begin
 l := nil; l2 := nil;
 inicializoVector (v);
 leoDatos (p);
 while (p.pm2 <> -1) do begin
  cargoDatos (p,l,l2,v);
  leoDatos (p);
 end;
 writeln ('-----------------------------');
 write ('Numero de zona: '); readln (nz);
 write ('Tipo de propiedad: '); readln (tp);
 retornoPropiedades (v,nz,tp);
 end.
