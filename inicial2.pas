program ejercicio2;
const
 max = 5;
type
 str = string[20];
 rango = 1..max;
 propiedad = record
  code: integer;
  tipo: str;
  ptotal: real; // = m2*pm2
 end;
 prop = record
  zona: rango;
  tp: str;
  codigo: integer;
  m2: real;
  pm2: real; 
 end;
 Lista = ^nodo;
 nodo = record
  dato: propiedad;
  sig: Lista;
 end;
 vector = array [rango] of Lista;
 estructura2 = record
  numzona: integer;
  tipe: str;
 end;
 Lista2 = ^nodo2;
 nodo2 = record
  dato2: estructura2;
  sig2: Lista2;
 end;
procedure LeerProp (var p:prop);
begin
 writeln ('zona: '); p.zona:= random(5)+1;
 write ('tipo de propiedad: '); readln (p.tp);
 writeln ('codigo: '); p.codigo:= random(200);
 writeln ('metros cuadrados: '); p.m2:= random(5000)-1;
 write ('precio por metro cuadrado: '); readln(p.pm2);
end;
procedure InsertarOrdenado1(var L: Lista; pd: propiedad);
var
  nue: lista;
  ant,act: lista;
begin
  ant:= l;
  act:= l;
  new(nue);
  nue^.dato:= pd;
  While(act <> nil) and ( pd.tipo> act^.dato.tipo )do
    begin
      ant:= act;
      act:= act^.sig;
    end;
  if(act = ant)then
    L:= nue
  else
    ant^.sig:= nue;
  nue^.sig:= act;
end;
procedure CargarListayVector1 (var L: Lista; var v:vector);
var
 p: prop;
 pd: propiedad;
 zone: rango;
begin
  L:= nil;
  LeerProp (p);
  writeln ('-----------------------------------------------------------');
  while (p.pm2 <> -1 ) do
  begin
   zone:= p.zona;
   pd.code:= p.codigo;
   pd.tipo:= p.tp;
   pd.ptotal:= p.m2 * p.m2;
   InsertarOrdenado1 (L , pd);
   v[zone]:= L;
   LeerProp (p);
   writeln ('-----------------------------------------------------------');
  end;
end;
procedure AgregarAdelante (var L2: Lista2; e2: estructura2);
var
 nuevo: Lista2;
begin
 new (nuevo);
 nuevo^.dato2:= e2;
 nuevo^.sig2:= L2;
 L2:= nuevo;
end;
procedure IncisoB (v: vector; nz: rango; tprop: str; var L2: Lista2; L: Lista);
var
 e2: estructura2;
begin
 while (L<> nil) do
 begin
  if ( L^.dato.tipo = tprop)  then
  begin
   Writeln('Codigos: ',L^.dato.code);
   e2.numzona:= L^.dato.code;
   e2.tipe:= tprop;
   AgregarAdelante (L2,e2);
  end;
  L:= L^.sig;
 end;
end;
var
 L: Lista;
 L2:Lista2;
 nz: rango;
 tprop: str;
 v: vector;
 fin: integer;
begin
 CargarListayVector1 (L,v);
 write ('fin: '); readln (fin);
 while (fin <> 0) do
 begin
  write ('nz: '); readln (nz);
  writeln ('-----------------------------------------------------------');
  write ('tprop: '); readln (tprop);
  writeln ('-----------------------------------------------------------');
  IncisoB (v,nz,tprop,L2, L);
  writeln ('-----------------------------------------------------------');
  write ('fin: ');
  readln (fin);
 end;
end.
 
