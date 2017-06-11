with Nt_Console,P_Graficas,P_Tipos_Datos,P_Mensajes;
use Nt_Console,P_Tipos_Datos;

package body P_Pacientes  is
   ---------------------------------------------
   package P_Mnj is new  P_Mensajes(55,7,30,10,Color_Fondo,White,Red);
   ---------------------------------------------
   package Pp is new P_Graficas (Tope_Nombre,Centrar_X,Centrar_Y,
      Color_Fondo,Magenta,Color_Fondo,White,Magenta,Black,Black,White);
   use Pp;
   ---------------------------------------------
   procedure Inicializo_Ok (
         Ok :    out T_Ok ) is 
   begin
      for I in T_Ok'range loop
         Ok(I):=' ';
      end loop;
   end Inicializo_Ok;
   ---------------------------------------------
   procedure Leer_Datos_P (
         Clinica  : in out T_Vec_Salas; 
         Paciente : in out T_Paciente   ) is 
      Esp        : P_L_Esp.T_Lista;  
      Eme        : P_L_Eme.T_Lista;  
      Menu       : Pp.P_L_Menu.T_Lista;  
      Tecla      : Character;  
      Ok         : T_Ok;  
      Encontrado : Boolean;  
      Posi       : Integer;  

   begin
      Plantilla_Doctor_Paciente(Color_Fondo,Black,White,Black,Gray,White,
         Black,Black,White,White);
      Entrada_Pacientes(Color_Fondo,Cyan,White);
      ---------------------------------------------------------
      Crear_Menu_Especialidad(Esp);
      Crear_Menu_Emergencia (Eme);
      Crear_Menu_Datos_Paciente (Menu);
      ---------------------------------------------------------
      Pp.P_L_Menu.Imprimir(Menu);
      Inicializo_Ok(Ok);
      loop
         Seleccionar_Dato(Centrar_X,Centrar_Y,Menu,Tecla);
         if (Character'Pos(Tecla)=13) then
            case Pp.P_L_Menu.Info(Menu).Indice is
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 0 =>
                  Paciente.Nombre.Nombre:=(others=>' ');
                  Pp.Leer_Texto (Where_X+10,Where_Y,
                     Paciente.Nombre.Nombre,20,Paciente.Nombre.Long_Nom);
                  while Paciente.Nombre.Long_Nom <=0 loop
                     Paciente.Nombre.Nombre:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);


                     --         Posi_X   : in     Nt_Console.X_Pos := Where_X; 
                     --         Posi_Y   : in     Nt_Console.Y_Pos := Where_Y; 
                     --         Cadena   :    out T_Cad;                       
                     --         Tope     : in     Natural;                     
                     --         Longitud :    out Natural     
                     Pp.Leer_Texto (X_Lec,10,Paciente.Nombre.Nombre,20,
                        Paciente.Nombre.Long_Nom);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(1):='1';
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 1 =>
                  Paciente.Nombre.Apellido:=(others=>' ');
                  Pp.Leer_Texto (Where_X+8,Where_Y,
                     Paciente.Nombre.Apellido,20,
                     Paciente.Nombre.Long_Apell);

                  while Paciente.Nombre.Long_Apell <=0 loop
                     Paciente.Nombre.Apellido:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,11,Paciente.Nombre.Apellido,20,
                        Paciente.Nombre.Long_Apell);
                  end loop;

                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);

                  Ok(2):='2';
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 2=>
                  Pp.Leer_Entero (Where_X+12,Where_Y,Paciente.Edad,3);
                  while (Paciente.Edad > 100) or (Paciente.Edad<1)  loop
                     Bleep;
                     Bleep;
                     P_Mnj.Dato_No_Valido (X_Msj,Y_Msj);
                     Goto_Xy (X_Lec,12);
                     Pp.Leer_Entero (Where_X,Where_Y,Paciente.Edad,3);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(3):='3';
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 3 =>
                  Seleccionar_Emergencia(Where_X+4,Where_Y,Eme);
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  if Pp.P_L_Eme.Info(Eme).Eme = "NO" then
                     Paciente.Ind_Emergencia:= False;
                  else
                     if Pp.P_L_Eme.Info(Eme).Eme = "SI" then
                        Paciente.Ind_Emergencia:= True;
                     end if;
                  end if;

                  Ok(4):='4';
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 4=>
                  Seleccionar_Especialidad(Where_X+2,Where_Y,Esp);
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Paciente.Especialidad.Esp:= Pp.P_L_Esp.Info(Esp).Esp;
                  Paciente.Especialidad.Long:= Pp.P_L_Esp.Info(Esp).Long;
                  -------------------------------------------------------------
                  Ok(5):='5';
               when others =>
                  null;
            end case;
         end if;
         exit when Ok="12345" or Character'Pos(Tecla)=27 ;
      end loop;
      if not (Character'Pos(Tecla)=27) then

         if Paciente.Especialidad.Esp= "    " and
               Paciente.Especialidad.Long = 4 then
            --Paciente no ingreso esp.
            Buscar_Doctor_Adecuado (Paciente,Clinica,Encontrado,Posi);
            if Encontrado then

               if Paciente.Ind_Emergencia then
                  Paciente.Prioridad:=Max_Priori_Alta;
               else
                  Paciente.Prioridad:=Max_Priori_Normal;
               end if;
               Clinica(Posi).Cant_Pacientes:=Clinica(Posi).Cant_Pacientes +
                  1 ;

               Asignar_Doctor_Paciente(Clinica(Posi).Cola_Espera,Paciente);
               P_Mnj.Sala_Para_Paciente(X_Msj,Y_Msj,Posi);
               Clinica(Posi).Cant_Pacientes:=Clinica(Posi).Cant_Pacientes +
                  1 ;
            else
               P_Mnj.No_Hay_Doctor(X_Msj,Y_Msj);
            end if;


         else--Paciente ingreso especialidad.
            Buscar_Doctor_Especial(Clinica,Paciente.Especialidad,
               Paciente.Ind_Emergencia,Encontrado,Posi);



            if  Encontrado then--Lo encontrado.


               if Paciente.Ind_Emergencia then
                  Paciente.Prioridad:=Max_Priori_Alta;
               else
                  Paciente.Prioridad:=Max_Priori_Normal;
               end if;

               Asignar_Doctor_Paciente(Clinica(Posi).Cola_Espera,Paciente);
               --Agrego el paciente a la cola.
               P_Mnj.Sala_Para_Paciente(X_Msj,Y_Msj,Posi);
               Clinica(Posi).Cant_Pacientes:=Clinica(Posi).Cant_Pacientes +
                  1 ;

            else
               P_Mnj.No_Hay_Doctor(X_Msj,Y_Msj);--Si no lo encuentra.
            end if;
         end if;
      end if;
   end Leer_Datos_P;
   ----------------------------------------------------------------------------------------------------------------------------------------

   procedure Salida_Paciente (
         Clinica : in out T_Vec_Salas ) is 
      Menu_S   : Pp.P_L_Menu.T_Lista;  
      Paciente : T_Paciente;  
      Tecla    : Character;  
      Ok       : T_Ok_I;  
      Esta,  
      Correcto : Boolean;  
      Lugar    : Integer;  

      procedure Inicio_Ok (
            Ok :    out T_Ok_I ) is 
      begin
         for I in T_Ok_I'range loop
            Ok(I):=' ';
         end loop;
      end Inicio_Ok;
   begin
      ----------------------------
      Plantilla_Doctor_Paciente(Color_Fondo,Black,White,Black,Gray,White,
         Black,Black,White,White);
      Salida_Pacientes(Color_Fondo,Cyan,White);
      ----------------------------
      Datos_Salida_Paciente (Menu_S);
      ----------------------------
      Pp.P_L_Menu.Imprimir(Menu_S);
      Inicio_Ok(Ok);
      loop
         Seleccionar_Dato(Centrar_X,Centrar_Y,Menu_S,Tecla);
         if (Character'Pos(Tecla)=13) then
            case Pp.P_L_Menu.Info(Menu_S).Indice is
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 0 =>
                  Paciente.Nombre.Nombre:=(others=>' ');
                  Pp.Leer_Texto (Where_X+10,Where_Y,
                     Paciente.Nombre.Nombre,20,Paciente.Nombre.Long_Nom);
                  while Paciente.Nombre.Long_Nom <=0 loop
                     Paciente.Nombre.Nombre:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,10,Paciente.Nombre.Nombre,20,
                        Paciente.Nombre.Long_Nom);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);
                  Ok(1):='1';
               ----------------------------------------------------------------------------------------------------------------------------------------
               when 1 =>
                  Paciente.Nombre.Apellido:=(others=>' ');
                  Pp.Leer_Texto (Where_X+8,Where_Y,
                     Paciente.Nombre.Apellido,20,
                     Paciente.Nombre.Long_Apell);

                  while Paciente.Nombre.Long_Apell <=0 loop
                     Paciente.Nombre.Apellido:=(others=>' ');
                     Bleep;
                     Bleep;
                     P_Mnj.No_Ingreso_Dato (X_Msj,Y_Msj);
                     Pp.Leer_Texto (X_Lec,11,Paciente.Nombre.Apellido,20,
                        Paciente.Nombre.Long_Apell);
                  end loop;
                  P_Mnj.Msj_Ing_Nom_Ok(X_Msj,Y_Msj);

                  Ok(2):='2';
               ----------------------------------------------------------------------------------------------------------------------------------------

               when others =>
                  null;
            end case;
         end if;
         exit when Ok="12" or Character'Pos(Tecla)=27 ;
         -- 27 es la tecla escape.
      end loop;


      if not (Character'Pos(Tecla)=27) then
         Esta:=False;
         for I in P_Estructura_Clinica.T_Indice_Salas'range loop
            --Me fijo si está.
            if not Clinica(I).Sala_Libre then
               if not Clinica(I).Disponible then
                  Esta:=Verificar_Paciente_Sala(Clinica(I),Paciente);
                  Lugar:=I;
               end if;
            end if;


         end loop;


         if not Esta then --El doctor no se encontró
            P_Mnj.No_Esta_Paciente(X_Msj,Y_Msj);
            P_Mnj.Ingrese_Nuevamente(X_Msj,Y_Msj);

         else --El doctor fue encontrado
            Correcto:=True;
            Clinica(Lugar).Cant_Pacientes:=Clinica(Lugar).Cant_Pacientes +
               1 ;
            Quitar_Paciente_Sala (Clinica(Lugar));

            P_Mnj.Pac_Salida_Ok (X_Msj,Y_Msj);

         end if;

      end if;


   end Salida_Paciente;
   ---------------------------------------------
   ---------------------------------------------
   ---------------------------------------------

   procedure Entrada_Paciente (
         Clinica : in out T_Vec_Salas ) is 
      Aux_Paciente : T_Paciente;  
   begin
      Leer_Datos_P (Clinica,Aux_Paciente);
   end Entrada_Paciente;
   ---------------------------------------------
end P_Pacientes;

