{1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y nota obtenida (sin contar los aplazos) en cada
una de las materias aprobadas. La lectura finaliza cuando se ingresa el número de alumno
11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne número
de alumno y promedio de cada alumno.
c) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?}


program ejercicio1;

type
str20 = string[20];
rango_mat = 0..36;
rango_nota = 4..10;

vnota = array [rango_mat] of rango_nota;

alumno = record
 ap : str20;
 num,anio : integer;
 cant : rango_mat;
 nota : vnota;
end;

lista = ^nodo;
nodo = record
 dato : alumno;
 sig : lista;
end;

procedure leoNotas (var n : vnota; cant:rango_mat);
var
 i : rango_mat; num:rango_nota;
begin
 for i := 1 to cant do begin
  write ('Nota de la materia ',i,': '); readln (num);
  n[i] := num;
 end;
end;

procedure leoAlumno (var a : alumno);
begin
 write ('Apellido: '); readln (a.ap);
 write ('Numero de alumno: '); readln (a.num);
 write ('Anio de ingreso: '); readln (a.anio); 
 write ('Cantidad de materias aprobadas: '); readln (a.cant);
 if (a.cant > 0) then
  leoNotas (a.nota,a.cant);
end;

procedure cargoLista (a : alumno; var l : lista);
var
 nuevo : lista;
begin
 new (nuevo);
 nuevo^.dato := a;
 nuevo^.sig := nil;
 if (l = nil) then
  l := nuevo
 else begin
  nuevo^.sig := l;
  l := nuevo;
 end;
end;

procedure calculo (var prom : real; cant : rango_mat; n : vnota);
var
 i: rango_mat;
begin
 for i := 1 to cant do
  prom := prom + n[i];
 prom := prom / cant;
end;

procedure informo (l : lista);
var
 prom : real;
begin
 while (l <> nil) do begin
  prom := 0;
  if (l^.dato.cant = 0) then begin
   writeln ('--------------------------------------------------------------');
   writeln ('El alumno ',l^.dato.num,' no tiene materias aprobadas. Su promedio es 0');
   writeln ('--------------------------------------------------------------');
  end
  else begin
   calculo (prom,l^.dato.cant,l^.dato.nota);
   writeln ('--------------------------------------------------------------');
   writeln ('El alumno ',l^.dato.num,' tiene promedio ',prom:2:2);
   writeln ('--------------------------------------------------------------');
  end;
  l := l^.sig;
 end;
end;

var
 a : alumno; l : lista;
begin
 l := nil;
 repeat
  leoAlumno (a);
  cargoLista (a,l);
 until (a.num = 11111);
 informo (l);
end.
