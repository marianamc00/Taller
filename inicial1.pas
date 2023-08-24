program ejercicio1;
const
 max = 36;
type
 str = string[20];
 rango = 1..max;
 rango2 = 4..10;
 vnotas = array [rango] of rango2;
 alumnos = record 
  ap: str;
  num: integer;
  anio: integer;
  aprob: integer;
  notas: vnotas;
 end;
 alumprom = record
  prom : real;
  nc: integer;
 end;
 Lista = ^nodo;
 nodo = record
  dato: alumnos;
  sig: Lista;
 end;
 Lista2 = ^nodo2;
 nodo2 = record
  dato2: alumprom;
  sig2: Lista2;
 end;
procedure LeerNotas (var vn:vnotas; cant: integer);
var
 i: rango; 
 nota: rango2;
begin
 for i:= 1 to cant do
 begin
  write ('nota', i, ':');
  readln (nota);
  vn[i]:= nota;
 end;
end;
procedure LeerAlumnos (var a:alumnos);
begin
 write('apellido: '); readln (a.ap);
 write ('numero: '); readln (a.num);
 write ('anio: '); readln (a.anio);
 write ('aprobadas: '); readln (a.aprob);
 LeerNotas (a.notas, a.aprob);
end;
procedure AgregarAdelante (var L:Lista; a:alumnos);
var
 nuevo: Lista;
begin
 new (nuevo);
 nuevo^.dato:= a;
 nuevo^.sig:= nil;
 if (L = nil) then
 begin
  L:= nuevo;
 end
 else
 begin
  nuevo^.sig:= L;
  L:= nuevo;
 end;
end;
procedure CargarLista (var L:Lista);
var
 a:alumnos;
begin
 repeat 
   LeerAlumnos (a);
   AgregarAdelante (L,a);
 until (a.num = 11111);
end;
procedure promedio ( var p: real; vn: vnotas ; cant: integer);
var
 suma: real;
 i: rango;
begin
 suma:= 0;
 for i:= 1 to cant do
  suma:= suma + vn[i];
 p:= suma / cant;
end;
procedure AgregarAdelante2 (var L2: Lista2; alp:alumprom );
var
 nuevo: Lista2;
begin
 new (nuevo);
 nuevo^.dato2 := alp;
 nuevo^.sig2:= nil;
 if (L2 = nil) then
 begin
  L2:= nuevo;
 end
 else
 begin
  nuevo^.sig2:= L2;
  L2:= nuevo;
 end;
end;
procedure incisoB (var L2: Lista2; L: Lista);
var
 alp:alumprom;
begin
 while (L <> nil) do
 begin
  promedio (alp.prom , L^.dato.notas , L^.dato.aprob);
  alp.nc := L^.dato.num;
  AgregarAdelante2 (L2, alp);
  writeln ('promedio de alumno numero' , alp.nc:1, ':' , alp.prom:1);
  L:= L^.sig;
 end;
end;
var
 L:Lista;
 L2: Lista2;
begin
 L:= nil;
 L2:= nil;
 CargarLista (L);
 incisoB (L2,L);
end.
 
