with P_Graficas,Nt_Console,P_Mensajes,Ada.Characters.Handling;
with P_Tipos_Datos,P_Mensajes;
use P_Tipos_Datos,Nt_Console,Ada.Characters.Handling;
--Instancia.
with P_Estructura_Clinica;
use P_Estructura_Clinica;

package body  P_Doctores is
   ----------------------------------
   --Este lo usan todos , pero los mensajes deben ser instanciados cada uno en el procedimiento que lo utilice.
   package Pp is new P_Graficas (Tope_Nombre,Centrar_X,Centrar_Y,Color_Fondo,Magenta,Color_Fondo,White,Magenta,Black,Black,White);
   use Pp;
   --   package Pp2 is new P_Graficas (Tope_Nombre,Centrar_X,Centrar_Y,Color_Fondo,Magenta,Color_Fondo,White,Magenta,Black,Black,White);
   --   use Pp2;
   package P_Mnj is new  P_Mensajes(55,7,20,10,Color_Fondo,White,Red);
   use P_Mnj;

   procedure Leer_Datos (
         Clinica  : in out T_Vec_Salas; 
         Doctor   : in out T_Doctor;    
         Correcto :    out Boolean      ) is 
      Esp     : Pp.P_L_Esp.T_Lista;  
      Menu    : Pp.P_L_Menu.T_Lista;  
      Tecla   : Character;  
      Entero  : Integer;  
      X_Ini   : X_Pos;  
      Y_Ini   : Y_Pos;  
      Ok      : T_Ok;  
      Sala_Ok : Boolean             := False;  
   begin
      Pp.Plantilla_Doctor_Paciente(Color_Fondo,Black,White,Black,Gray,White,Black,Black,White,White); -- los colores ya estan configurados 
      Pp.Entrada_Doctores(Color_Fondo,Cyan,White); -- Se imprime el mensaje salida
      Crear_Menu_Especialidad_Doc(Esp);--Crea las listas utilizadas para el menú.
      Crear_Menu_Datos(Menu);
      Pp.P_L_Menu.Imprimir(Menu);--Imprime el menú creado.
      Ok:=(others=>' ');--Ésta sirve para salir de la toma de datos.
      loop
         Seleccionar_Dato(Centrar_X,Centrar_Y,Menu,Tecla);
         if (Character'Pos(Tecla)=13) then
            case Pp.P_L_Menu.Info(Menu).Indice is
               when 0 =>
                  Pp.Leer_Texto(x_lec,Where_Y,Doctor.Nombre.Nombre,20,Doctor.Nombre.Long_Nom); --Lectura correspondiente al menu .
                  while Doctor.Nombre.Long_nom <=0 loop
                     Doctor.Nombre.nombre:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,10,Doctor.Nombre.nombre,20,Doctor.Nombre.Long_nom);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(1):='1';
               
               when 1 =>
                  Pp.Leer_Texto(x_lec,Where_Y,Doctor.Nombre.Apellido,20,Doctor.Nombre.Long_Apell);

                  while Doctor.Nombre.Long_Apell <=0 loop
                     Doctor.Nombre.Apellido:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,11,Doctor.Nombre.Apellido,20,Doctor.Nombre.Long_Apell);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(2):='2';
                  
               when 2=>
                  X_Ini:=Where_X;
                  Y_Ini:=Where_Y;
                  loop
                     Sala_Ok:=False;
                     Goto_Xy(X_Ini,Y_Ini);
                     Pp.Leer_Entero(x_lec,Y_Ini,Entero,3);

                     if Entero>0 and Entero <= Integer((P_Estructura_Clinica.T_Indice_Salas'Last)) then
                        --Consisto
                        if Clinica(Entero).Sala_Libre then
                           --Agregué que no deje ingresar si la sala no está libre.
                           Doctor.Numero_Sala:= P_Tipos_Datos.T_Indice_Salas(Entero);
                           Ok(3):='3';
                           Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                           Sala_Ok:=True;
                        else
                           P_Mnj.Sala_Ocupada(X_Msj,Y_Msj);
                           Ingrese_Nuevamente(X_Msj,Y_Msj);
                        end if;
                     else
                        P_Mnj.Mensaje_Sala_Novalida(X_Msj,Y_Msj);
                        Ingrese_Nuevamente(X_Msj,Y_Msj);

                     end if;
                     exit when Sala_Ok;

                  end loop;
               when 3 =>
                  Seleccionar_Especialidad(where_x+2,Where_Y  ,Esp);
                  Doctor.Especialidad.Esp:= Pp.P_L_Esp.Info(Esp).Esp;
                  Doctor.Especialidad.Long:= Pp.P_L_Esp.Info(Esp).Long;
                  Ok(4):='4';

               when others =>
                  null;

            end case;

         end if;

         exit when Ok="1234" or Character'Pos(Tecla)=27 ;   -- 27 es la tecla escape.
      end loop;

      if Character'Pos(Tecla)=27 then --Si puso un escape entonces no ingreso bien el dato.
         Correcto:=False;
      else
         Correcto:=True;
      end if;

   end Leer_Datos;




   procedure Entrada_Doctor (
         Clinica : in out T_Vec_Salas ) is 
      Aux_Doctor : T_Doctor;  
      Esta       : Boolean;  
      Correcto   : Boolean;  

   begin
      Leer_Datos(Clinica,Aux_Doctor,Correcto);--Devuelve los datos en aux_doctor consistidos.

      --Me fijo si el doctor a está en la clinica.
      for I in P_Estructura_Clinica.T_Indice_Salas loop
         --Me fijo si está.
         if not clinica(i).sala_libre then----------QUE LA SALA ESTE OCUPADA!!!!!!!! MODIFICACION
         if To_Upper(Clinica(I).Doctor.Nombre.Nombre(1..Clinica(I).Doctor.Nombre.Long_Nom)) =
               To_Upper (Aux_Doctor.Nombre.Nombre(1..Aux_Doctor.Nombre.Long_Nom) ) and To_Upper(Clinica(I).Doctor.Nombre.Apellido(1..Clinica(I).Doctor.Nombre.Long_Apell)) =
               To_Upper (Aux_Doctor.Nombre.Apellido(1..Aux_Doctor.Nombre.Long_Apell) )then
            --Se fija si el nombre es igual al que fue ingresado (MAYUSCULIZADO).
            --Tambien el apellido
            Esta:=True;
            end if;
           end if;
      end loop;
      
      --MODIFICACION !!!!!!!!!!!!!!!
--------------------------------------------------------------------------------------------
      if Correcto and not Esta then --Si se ingreso dato y el doctor no esta actualmente.


         Asignar_Sala_Doctor(Aux_Doctor,Clinica(Integer(Aux_Doctor.Numero_Sala)));--Asigna la variable entrada a la estructura.
      else
         if Esta then 
                           Esta_Atendiendo(X_Msj,Y_Msj);--El doctor ya se encuentra atendiendo
         end if;
         
         if not Correcto then
            Dato_Ing_Invalido (X_Msj,Y_Msj);

            end if;
      end if;
      
----------------------------------------------------------------------------------------------

   end Entrada_Doctor;




   procedure Salida_Doctor (
         Clinica : in out T_Vec_Salas ) is --Devuelve el nombre del doctor que debe ser Suprimido de la estructura en un registro.
      Menu_Salida : Pp.P_L_Menu.T_Lista;  
      Ok          : T_Ok;                         --Uso el Ok de long 4 , pero uso solamente los primeros dos... los demás están en cero.
      Tecla       : Character;  
      Doctor      : T_Doctor;  
      Correcto    : Boolean             := False;  
      Esta        : Boolean             := False; ----------------Es solo de soporte para probar.
      Lugar       : Integer;  
      Hay_Otro    : Boolean;  
   begin

      Pp.Plantilla_Doctor_Paciente(Color_Fondo,Black,White,Black,Gray,White,Black,Black,White,White); -- los colores ya estan configurados 
      Pp.Salida_Doctores(Color_Fondo,Cyan,White); -- Se imprime el mensaje salida
      Crear_Menu_Ing_Nom_Doc(Menu_Salida);--Creo la lista para manejar el menú.
      Pp.P_L_Menu.Imprimir(Menu_Salida);--Imprime el menú creado.
      Ok:=(others=>'0');--Ésta sirve para salir de la toma de datos.
      loop--Selección en el menú.
         Seleccionar_Dato(Centrar_X,Centrar_Y,Menu_Salida,Tecla);
         if (Character'Pos(Tecla)=13) then
            case Pp.P_L_Menu.Info(Menu_Salida).Indice is
               when 0 =>
                  Pp.Leer_Texto(x_lec,Where_Y,Doctor.Nombre.Nombre,20,Doctor.Nombre.Long_Nom); --Lectura correspondiente al menu .
                  while Doctor.Nombre.Long_nom <=0 loop
                     Doctor.Nombre.nombre:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,10,Doctor.Nombre.nombre,20,Doctor.Nombre.Long_nom);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(1):='1';

               when 1 =>
                  Pp.Leer_Texto(x_lec,Where_Y,Doctor.Nombre.Apellido,20,Doctor.Nombre.Long_Apell);

                  while Doctor.Nombre.Long_Apell <=0 loop
                     Doctor.Nombre.Apellido:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,11,Doctor.Nombre.Apellido,20,Doctor.Nombre.Long_Apell);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(2):='1';
               when others=>
                  null;

            end case;
         end if;

         exit when Ok="1100" or Character'Pos(Tecla)=27 ; -- 27 es la tecla escape.
      end loop;

      --Esto lo tengo que hacer si y solo si ok=1100 en caso contrario fue un esc.
      if Ok="1100" then

         for I in P_Estructura_Clinica.T_Indice_Salas'range loop
            --Me fijo si está.
            if To_Upper(Clinica(I).Doctor.Nombre.Nombre(1..Clinica(I).Doctor.Nombre.Long_Nom)) =
                  To_Upper (Doctor.Nombre.Nombre(1..Doctor.Nombre.Long_Nom) ) and To_Upper(Clinica(I).Doctor.Nombre.Apellido(1..Clinica(I).Doctor.Nombre.Long_Apell)) =
                  To_Upper (Doctor.Nombre.Apellido(1..Doctor.Nombre.Long_Apell) )then
               --Se fija si el nombre es igual al que fue ingresado (MAYUSCULIZADO).
               --Tambien el apellido
               Esta:=True;
               Lugar:=I;
            end if;
         end loop;

         if not Esta then --El doctor no se encontró
            No_Esta_Doctor(X_Msj,Y_Msj);
--            Ingrese_Nuevamente(X_Msj,Y_Msj);

         else --El doctor fue encontrado
            Correcto:=True;
            
            if Haypacientes (Clinica(Lugar).Cola_Espera)then--Debo ver si tiene pacientes.
               Asignar_Pacientes_Otrosdoc(Clinica,Lugar,Hay_Otro);
               if Hay_Otro then--Si encuentra otro lo saco.
                  Quitar_Sala_Doctor(Clinica(Lugar));
                  Doc_Salida_Ok(X_Msj,Y_Msj);
                  Se_Creo_Planilla(X_Msj,Y_Msj);
               else--Si no hay pacientes.
                  No_Se_Puede_Ir(X_Msj,Y_Msj);

               end if;
            else--Si no tiene pacientes saco al doctor.
               if clinica(lugar).disponible then
               Quitar_Sala_Doctor(Clinica(Lugar));
                  Doc_Salida_Ok(X_Msj,Y_Msj);
               else
                  Paciente_siendo_atendido(X_Msj,Y_Msj);
                  end if;
            end if;
         end if;
      end if;
   end Salida_Doctor;

end P_Doctores;
