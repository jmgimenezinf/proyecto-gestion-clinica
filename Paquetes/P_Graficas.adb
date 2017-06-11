--FINAL
with Ada.Text_Io,Nt_Console,Ada.Characters.Handling,P_L_Doble_Enlazada,P_Tipos_Datos,P_Acentos;
use Ada.Text_Io,Nt_Console,Ada.Characters.Handling,P_Tipos_Datos,P_Acentos;

package body P_Graficas  is


   procedure Lee_Flotante (
         Cadena :    out T_Cad;   
         Long   :    out Integer; 
         Tope   : in     Integer  ) is 
      I     : Integer;  
      Tecla : Character;  
      Salir : exception;  

   begin
      I:=0;

      loop
         Tecla:=Get_Key;

         case Character'Pos(To_Upper(Tecla)) is
            when 27 =>
               raise Salir;
            when 13 =>
               null;
            when 8 =>
               if I=0 then
                  Bleep;
               else
                  I:=I-1;
                  Goto_Xy(Where_X-1,Where_Y);
                  Put(" ");
                  Goto_Xy(Where_X-1,Where_Y);
               end if;
            when 45 =>
               if I=0 then
                  Put(Tecla);
                  I:=I+1;
                  Cadena(I):=Tecla;

               end if;
            when 46 =>
               if not (I=0) then
                  if  not (Character'Pos(Cadena(I)) = 46 or Character'Pos(Cadena(I)) =44) then
                     Put(Tecla);
                     I:=I+1;
                     Cadena(I):=Tecla;
                  end if;
               end if;

            when 48..57 =>
               Put(Tecla);
               I:=I+1;
               Cadena(I):=Tecla;

            when others =>
               Bleep;
               Bleep;

         end case;

         if I=Tope then
            loop
               Bleep;
               Get_Immediate(Tecla);
               exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=8;
            end loop;
         end if;

         exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=27;
      end loop;

      Long:=I;

   exception
      when Salir =>
         Long:=0;


   end Lee_Flotante;


   procedure Lee_Entero (
         Cadena :    out T_Cad;   
         Long   :    out Integer; 
         Tope   : in     Integer  ) is 
      I     : Integer;  
      Tecla : Character;  
      Salir : exception;  

   begin
      I:=0;

      loop
         Tecla:=Get_Key;

         case Character'Pos(To_Upper(Tecla)) is
            when 27 =>
               raise Salir;
            when 13 =>
               null;
            when 8 =>
               if I=0 then
                  Bleep;
               else
                  I:=I-1;
                  Goto_Xy(Where_X-1,Where_Y);
                  Put(" ");
                  Goto_Xy(Where_X-1,Where_Y);
               end if;
            when 45 =>
               if I=0 then
                  Put(Tecla);
                  I:=I+1;
                  Cadena(I):=Tecla;

               end if;


            when 48..57 =>
               Put(Tecla);
               I:=I+1;
               Cadena(I):=Tecla;

            when others =>
               Bleep;


         end case;

         if I=Tope then
            loop
               Bleep;
               Get_Immediate(Tecla);
               exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=8;
            end loop;
         end if;

         exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=27;
      end loop;

      Long:=I;

   exception
      when Salir =>
         Long:=0;


   end Lee_Entero;





   procedure Lee_Texto (
         Cadena :    out T_Cad;   
         Long   :    out Integer; 
         Tope   : in     Integer  ) is 
      I       : Integer;  
      Tecla   : Character;  
      Salir   : exception;  
      Flechas : Boolean;  
      X,  
      Y       : Natural;  

   begin
      I:=0;

      loop
         X:=Where_X;
         Y:=Where_Y;
         Leer_Caracter(Tecla,Flechas);

         case Character'Pos(To_Upper(Tecla)) is

            when 27 =>
               raise Salir;
            when 13 =>
               null;
            when 8 =>
               if I=0 then
                  Bleep;
               else
                  I:=I-1;
                  Goto_Xy(Where_X-1,Where_Y);
                  Put(" ");
                  Goto_Xy(Where_X-1,Where_Y);
               end if;
            when 65..90|32  =>
               if not Flechas then
                  Put(Tecla);
                  I:=I+1;
                  Cadena(I):=Tecla;
               end if;



            when others =>
               Bleep;

         end case;

         if I=Tope then
            loop
               Bleep;
               Get_Immediate(Tecla);
               exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=8;
            end loop;
         end if;

         exit when Character'Pos(Tecla)=13 or Character'Pos(Tecla)=27;
      end loop;

      Long:=I;

   exception
      when Salir =>
         Long:=0;

   end Lee_Texto;



   procedure Leer_Texto (
         Posi_X   : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y   : in     Nt_Console.Y_Pos := Where_Y; 
         Cadena   :    out T_Cad;                       
         Tope     : in     Natural;                     
         Longitud :    out Natural                      ) is 

   begin
      Set_Cursor(True);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Entrada);
      Set_Foreground(Letra_Entrada);

      for I in 1..Tope loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Lee_Texto(Cadena,Longitud,Tope);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      Set_Foreground(Letra_Salida);

      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);

      if Longitud /=0 then
         Goto_Xy(Posi_X + Correr_Izquierda,Posi_Y);
       
       
         Put(To_Upper(Cadena(1)));
         Goto_Xy(Posi_X +1+ Correr_Izquierda,Posi_Y);
         Put(to_lower(Cadena(2..Longitud)));
      end if;

   end Leer_Texto;




   procedure Leer_Entero (
         Posi_X : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y : in     Nt_Console.Y_Pos := Where_Y; 
         Entero :    out Integer;                     
         Tope   : in     Natural                      ) is 
      Cadena   : T_Cad;  
      Longitud : Natural;  

   begin
      Set_Cursor(True);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Entrada);
      Set_Foreground(Letra_Entrada);

      for I in 1..Tope loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Lee_Entero(Cadena,Longitud,Tope);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      Set_Foreground(Letra_Salida);

      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      if Longitud /=0 then
         Goto_Xy(Posi_X + Correr_Izquierda,Posi_Y);
         Put(Cadena(1..Longitud));
         Entero:= Integer'Value(Cadena(1..Longitud));
      end if;
      Set_Cursor(False);
   exception
      when Constraint_Error=>
         Entero:=0;


   end Leer_Entero;


   procedure Leer_Flotante (
         Posi_X   : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y   : in     Nt_Console.Y_Pos := Where_Y; 
         Flotante :    out Float;                       
         Tope     : in     Natural                      ) is 
      Cadena   : T_Cad;  
      Longitud : Natural;  
   begin
      Set_Cursor(True);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Entrada);
      Set_Foreground(Letra_Entrada);

      for I in 1..Tope loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);
      Lee_Flotante(Cadena,Longitud,Tope);
      Goto_Xy(Posi_X,Posi_Y);
      Set_Background(Fondo_Salida);
      Set_Foreground(Letra_Salida);

      for I in 1..Tope + Correr_Izquierda loop
         Put(" ");
      end loop;

      Goto_Xy(Posi_X,Posi_Y);

      if Longitud /=0 then
         Goto_Xy(Posi_X + Correr_Izquierda,Posi_Y);
         Put(Cadena(1..Longitud));
         Flotante:= Float'Value(Cadena(1..Longitud));
      end if;

   exception
      when Constraint_Error=>
         Flotante:=0.0;

   end Leer_Flotante;

   -- MENUES 

   procedure Crear_Menu_Datos (
         Menu :    out P_L_Menu.T_Lista ) is  -- es un ejemplo de menu.(crear otro y ponerlo en el ads para que sea visible)
      Reg  : T_Menu;  
      Temp : P_L_Menu.T_Lista;  
   begin
      P_L_Menu.Crear(Temp);
      for I in 0..3 loop
         Reg.Indice:=I;
         case I is
            when 0 =>
               Reg.Titulo(1..6):="Nombre"; -- Poner longitud correcta
               Reg.Long:=6; --poner longitud correcta
            when 1 =>
               Reg.Titulo(1..8):="Apellido";
               Reg.Long:=8;
            when 2 =>
               Reg.Titulo(1..14):="N"&Ú&"mero de sala";
               Reg.Long:=14;
            when 3 =>
               Reg.Titulo(1..12):="Especialidad";
               Reg.Long:=12;

         end case;
         P_L_Menu.Insertar(Temp,Reg);
      end loop;
      P_L_Menu.Crear(Menu);
      for I in 0..3 loop
         P_L_Menu.Insertar(Menu,Info(Temp));
         Temp:=P_L_Menu.Siguiente(Temp);
      end loop;
      P_L_Menu.Limpiar(Temp);

   end Crear_Menu_Datos;
   
   procedure Datos_Salida_Paciente (Menu:out P_L_Menu.T_Lista) is  ----AGREGADO NENEN 20 - 06 - 14
      
      Reg:T_Menu;
      temp:P_l_menu.T_lista;
   begin
      P_L_Menu.Crear(temp);
      for I in 0..1 loop
         Reg.Indice:=I;
         case I is 
            when 0 => Reg.Titulo(1..6):="Nombre"; -- Poner longitud correcta
               Reg.Long:=6; --poner longitud correcta
            when 1 => Reg.Titulo(1..8):="Apellido";
               Reg.Long:=8;
         end case;
         P_L_Menu.insertar(temp,Reg);
      end loop;
      P_L_Menu.Crear(menu);
      for I in 0..1 loop
         P_L_Menu.Insertar(Menu,Info(Temp));
         Temp:=P_L_Menu.Siguiente(Temp);
      end loop;
      P_L_Menu.Limpiar(Temp);
   end Datos_Salida_Paciente;


   --Este menú lo creé para manejar los doctores.
   
   procedure Crear_Menu_Ing_Nom_Doc (
         Menu :    out P_L_Menu.T_Lista ) is  -- es un ejemplo de menu.(crear otro y ponerlo en el ads para que sea visible)
      Reg  : T_Menu;  
      Temp : P_L_Menu.T_Lista;  
   begin
      P_L_Menu.Crear(Temp);
      for I in 0..1 loop
         Reg.Indice:=I;
         case I is
            when 0 =>
               Reg.Titulo(1..6):="Nombre"; -- Poner longitud correcta
               Reg.Long:=6; --poner longitud correcta
            when 1 =>
               Reg.Titulo(1..8):="Apellido";
               Reg.Long:=8;
            
         end case;
         P_L_Menu.Insertar(Temp,Reg);
      end loop;
      P_L_Menu.Crear(Menu);
      for I in 0..1 loop
         P_L_Menu.Insertar(Menu,Info(Temp));
         Temp:=P_L_Menu.Siguiente(Temp);
      end loop;
      P_L_Menu.Limpiar(Temp);

   end Crear_Menu_Ing_Nom_Doc;
   

 procedure Crear_Menu_Especialidad (
         Menu :    out P_L_Esp.T_Lista ) is  -- es un ejemplo de menu.(crear otro y ponerlo en el ads para que sea visible)

      Reg : P_Tipos_datos.T_Esp;  
   begin
      P_L_Esp.Crear(Menu);
      for I in 0..12 loop
         case I is
            when 0 =>
               Reg.Esp(1..3):="PED";
               Reg.Long:=3;
            when 1 =>
               Reg.Esp(1..2):="MG";
               Reg.Long:=2;
            when 2 =>
               Reg.Esp(1..3):="INT";
               Reg.Long:=3;
            when 3=>
               Reg.Esp(1..1):="C";
               Reg.Long:=1;
            when 4=>
               Reg.Esp(1..4):="CIRG";
               Reg.Long:=4;
            when 5=>
               Reg.Esp(1..3):="OBS";
               Reg.Long:=3;
            when 6=>
               Reg.Esp(1..3):="PSY";
               Reg.Long:=3;
            when 7=>
               Reg.Esp(1..4):="NEUR";
               Reg.Long:=4;
            when 8=>
               Reg.Esp(1..4):="ORTO";
               Reg.Long:=4;
            when 9=>
               Reg.Esp(1..4):="DERM";
               Reg.Long:=4;
            when 10=>
               Reg.Esp(1..3):="OFT";
               Reg.Long:=3;
            when 11=>
               Reg.Esp(1..3):="OTO";
               Reg.Long:=3;
            when 12 =>
               Reg.Esp(1..4):="    ";
               Reg.Long:=4;
            when others =>
               null;
         end case;
         P_L_Esp.Insertar(Menu,Reg);
      end loop;

   end Crear_Menu_Especialidad;

   --------------
    procedure Crear_Menu_Especialidad_DOC (
         Menu :    out P_L_Esp.T_Lista ) is  -- es un ejemplo de menu.(crear otro y ponerlo en el ads para que sea visible)

      Reg : P_Tipos_datos.T_Esp;  
   begin
      P_L_Esp.Crear(Menu);
      for I in 0..11 loop
         case I is
            when 0 =>
               Reg.Esp(1..3):="PED";
               Reg.Long:=3;
            when 1 =>
               Reg.Esp(1..2):="MG";
               Reg.Long:=2;
            when 2 =>
               Reg.Esp(1..3):="INT";
               Reg.Long:=3;
            when 3=>
               Reg.Esp(1..1):="C";
               Reg.Long:=1;
            when 4=>
               Reg.Esp(1..4):="CIRG";
               Reg.Long:=4;
            when 5=>
               Reg.Esp(1..3):="OBS";
               Reg.Long:=3;
            when 6=>
               Reg.Esp(1..3):="PSY";
               Reg.Long:=3;
            when 7=>
               Reg.Esp(1..4):="NEUR";
               Reg.Long:=4;
            when 8=>
               Reg.Esp(1..4):="ORTO";
               Reg.Long:=4;
            when 9=>
               Reg.Esp(1..4):="DERM";
               Reg.Long:=4;
            when 10=>
               Reg.Esp(1..3):="OFT";
               Reg.Long:=3;
            when 11=>
               Reg.Esp(1..3):="OTO";
               Reg.Long:=3;
            when others =>
               null;
         end case;
         P_L_Esp.Insertar(Menu,Reg);
      end loop;

   end Crear_Menu_Especialidad_DOC;



   -- SELECCION DE DATOS EN MENU 
   procedure Seleccionar_Dato (
         Centrar_X :        X_Pos;            
         Centrar_Y :        Y_Pos;            
         Datos     : in out P_L_Menu.T_Lista; 
         Tecla     :    out Character         ) is 


   begin
      Set_Cursor(False);
      Set_Foreground(Titulo_Seleccion);
      Set_Background(Fondo_Seleccion);
      Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
      Put( Info(Datos).Titulo(1..Info(Datos).Long));
      loop
         Get_Immediate(Tecla);
         if Tecla=Key_Up then

            if not P_L_Menu.Vacia(Anterior(Datos)) then
               Set_Foreground(Titulo);
               Set_Background(Fondo_Salida);
               Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
               Put(Info(Datos).Titulo(1..Info(Datos).Long));
               Datos:=Anterior(Datos);
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Seleccion);
               Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
               Put( Info(Datos).Titulo(1..Info(Datos).Long));
            end if ;

         elsif Tecla=Key_Down then

            if not P_L_Menu.Vacia(Siguiente(Datos))then
               Set_Foreground(Titulo);
               Set_Background(Fondo_Salida);
               Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
               Put( Info(Datos).Titulo(1..Info(Datos).Long));
               Datos:=Siguiente(Datos);
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Seleccion);
               Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
               Put( Info(Datos).Titulo(1..Info(Datos).Long));
            end if;
         else
            null;
         end if;
         exit when ((Character'Pos(Tecla)=13) or (Character'Pos(Tecla)=27));
      end loop;
      Set_Foreground(Titulo);
      Set_Background(Fondo_Salida);
      Goto_Xy(Centrar_X,Info(Datos).Indice + Centrar_Y);
      Put( Info(Datos).Titulo(1..Info(Datos).Long));


   end Seleccionar_Dato;






   procedure Seleccionar_Especialidad (
         X    :        X_Pos;          
         Y    :        Y_Pos;          
         Menu : in out P_L_Esp.T_Lista ) is 
      Rta : Character;  
   begin
      Set_Background(Fondo_Salida);
      Set_Foreground(Titulo_Seleccion);
      Goto_Xy(X,Y);
      Put(Character'Val(17));
      Goto_Xy(X + Integer(P_Tipos_Datos.T_Cad_esp'Last + 4),Y);
      Put(Character'Val(16));

      Set_Foreground(Titulo_Seleccion);
      Set_Background(Fondo_Entrada);
      Goto_Xy(X+2,Y);
      for I in 1.. P_Tipos_Datos.T_Cad_esp'Last +1  loop
         Put(" ");
      end loop;


      loop
         Goto_Xy(X+2,Y);
         Put(Info(Menu).Esp(1..Info(Menu).Long));
         Goto_Xy(X+2,Y);
         Get_Immediate(Rta);
         if Rta=Key_Left then
            if not Vacia(Anterior(Menu)) then

               Menu:=Anterior(Menu);
               Goto_Xy(X+2,Y);
               for I in 1.. T_Cad_esp'Last + 1 loop
                  Put(" ");
               end loop;

               Set_Foreground(Fondo_Entrada);
               Set_Background(Titulo_Seleccion);

               Goto_Xy(X,Y);
               Put(Character'Val(17));
               delay 0.04;
               Set_Background(Fondo_Salida);
               Set_Foreground(Titulo_Seleccion);
               Goto_Xy(X,Y);
               Put(Character'Val(17));
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Entrada);

            end if;



         elsif Rta=Key_Right then
            if not Vacia(Siguiente(Menu)) then
               Menu:=Siguiente(Menu);
               Goto_Xy(X+2,Y);
               for I in 1..T_Cad_esp'Last + 1 loop
                  Put(" ");
               end loop;

               Set_Foreground(Fondo_Entrada);
               Set_Background(Titulo_Seleccion);
               Goto_Xy(X + Integer(P_Tipos_Datos.T_Cad_esp'Last + 4),Y);
               Put(Character'Val(16));
               delay 0.04;
               Set_Background(Fondo_Salida);
               Set_Foreground(Titulo_Seleccion);
               Goto_Xy(X + Integer(P_Tipos_Datos.T_Cad_esp'Last + 4),Y);
               Put(Character'Val(16));
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Entrada);
            end if;



         end if;
         exit when Character'Pos(Rta)=13 ;
      end loop;


      Set_Foreground(Titulo);
      Set_Background(Fondo_Salida);
      Goto_Xy(X+2,Y);
      for I in 1.. P_Tipos_Datos.T_Cad_esp'Last +1  loop
         Put(" ");
      end loop;
      Set_Foreground(Letra_Salida);
      Goto_Xy(X+2,Y);
      Put( Info(Menu).Esp(1..Info(Menu).Long));


      Goto_Xy(X,Y);
      Put(" ");
      Goto_Xy(X + Integer(P_Tipos_Datos.T_Cad_esp'Last + 4),Y);
      Put(" ");


   end Seleccionar_Especialidad;
 procedure Seleccionar_Emergencia (
         X    :        X_Pos;          
         Y    :        Y_Pos;          
         Menu : in out P_L_Eme.T_Lista ) is ---AGREGADO NENEN 19 - 06 - 14

      Rta : Character;  
   begin
      Set_Background(Fondo_Salida);
      Set_Foreground(Titulo_Seleccion);
      Goto_Xy(X,Y);
      Put(Character'Val(17));
      Goto_Xy(X + Integer(P_Tipos_Datos.T_Eme'Last + 4),Y);
      Put(Character'Val(16));

      Set_Foreground(Titulo_Seleccion);
      Set_Background(Fondo_Entrada);
      Goto_Xy(X+2,Y);
      for I in 1.. P_Tipos_Datos.T_Eme'Last +1  loop
         Put(" ");
      end loop;


      loop
         Goto_Xy(X+2,Y);
         Put(Info(Menu).Eme(1..Info(Menu).Long_Eme));
         Goto_Xy(X+2,Y);
         Get_Immediate(Rta);
         if Rta=Key_Left then
            if not Vacia(Anterior(Menu)) then

               Menu:=Anterior(Menu);
               Goto_Xy(X+2,Y);
               for I in 1..T_Eme'Last + 1 loop
                  Put(" ");
               end loop;

               Set_Foreground(Fondo_Entrada);
               Set_Background(Titulo_Seleccion);

               Goto_Xy(X,Y);
               Put(Character'Val(17));
               delay 0.04;
               Set_Background(Fondo_Salida);
               Set_Foreground(Titulo_Seleccion);
               Goto_Xy(X,Y);
               Put(Character'Val(17));
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Entrada);

            end if;

         elsif Rta=Key_Right then
            if not Vacia(Siguiente(Menu)) then
               Menu:=Siguiente(Menu);
               Goto_Xy(X+2,Y);
               for I in 1..T_Eme'Last + 1 loop
                  Put(" ");
               end loop;

               Set_Foreground(Fondo_Entrada);
               Set_Background(Titulo_Seleccion);
               Goto_Xy(X + Integer(P_Tipos_Datos.T_Eme'Last + 4),Y);
               Put(Character'Val(16));
               delay 0.04;
               Set_Background(Fondo_Salida);
               Set_Foreground(Titulo_Seleccion);
               Goto_Xy(X + Integer(P_Tipos_Datos.T_Eme'Last + 4),Y);
               Put(Character'Val(16));
               Set_Foreground(Titulo_Seleccion);
               Set_Background(Fondo_Entrada);
            end if;
         end if;
         exit when Character'Pos(Rta)=13 ;
      end loop;

      Set_Foreground(Titulo);
      Set_Background(Fondo_Salida);
      Goto_Xy(X+2,Y);
      for I in 1.. P_Tipos_Datos.T_Eme'Last +1  loop
         Put(" ");
      end loop;
      Set_Foreground(Letra_Salida);
      Goto_Xy(X+2,Y);
      Put( Info(Menu).Eme(1..Info(Menu).Long_Eme));

      Goto_Xy(X,Y);
      Put(" ");
      Goto_Xy(X + Integer(P_Tipos_Datos.T_Eme'Last + 4),Y);
      Put(" ");
   end Seleccionar_Emergencia;



   -- NUEVOS PROCEDIMIENTOS

   procedure Cuadro (
         X       : X_Pos;     
         Y       : Y_Pos;     
         Ancho   : X_Pos;     
         Largo   : Y_Pos;     
         C_Borde : Color_Type ) is 


   begin

      Set_Foreground(C_Borde);

      for I in 0..Largo loop
         Goto_Xy(X+I,Y);
         Put(Character'Val(205));
         Goto_Xy(X+I,Ancho+Y);
         Put(Character'Val(205));
      end loop;
      Goto_Xy(X,Y);
      for I in 0..Ancho loop
         Goto_Xy(X,Y+I);
         Put(Character'Val(186));
         Goto_Xy(Largo+X,Y+I);
         Put(Character'Val(186));
      end loop;


      Goto_Xy(X,Y);
      Put(Character'Val(201)); --izquierda arriba
      Goto_Xy(Largo+X,Ancho+Y);
      Put(Character'Val(188)); -- derecha abajo
      Goto_Xy(Largo+X,Y);
      Put(Character'Val(187));
      Goto_Xy(X,Ancho+Y);
      Put(Character'Val(200));

   end Cuadro;


   procedure Entrada_Doctores(fondo,Presentacion,                    
         Titulo_Presentacion:Color_type) is 
   begin
               Set_Background(Presentacion);
         Set_foreground(Titulo_Presentacion);
         for J in 0..Max_Buffer_Col loop
            for I in 1..3 loop
               Goto_Xy(J,I);
               Put(" ");
         end loop;
      end loop;
      
            Goto_Xy(20,2);
      Put("        L A  C L I N "&í&" C A  -  D O C T O R E S");
      Goto_Xy(23,6);
       Set_Background(fondo);
   Set_Foreground(light_blue); 
   Put(" ENTRADA ");
   end Entrada_Doctores;
   


   procedure salida_Doctores( fondo,Presentacion,                    
         Titulo_Presentacion:Color_type) is 
   begin
               Set_Background(Presentacion);
         Set_foreground(Titulo_Presentacion);
         for J in 0..Max_Buffer_Col loop
            for I in 1..3 loop
               Goto_Xy(J,I);
               Put(" ");
         end loop;
      end loop;
      
            Goto_Xy(20,2);
      Put("        L A  C L "&í&" N I C A  -  D O C T O R E S");
        Goto_Xy(23,6);
      Set_Foreground(Light_Red); 
      Set_Background(fondo);
   Put(" SALIDA ");
   end Salida_Doctores;
   

   procedure salida_pacientes( fondo,Presentacion,                    
         Titulo_Presentacion:Color_type) is 
   begin
               Set_Background(Presentacion);
         Set_foreground(Titulo_Presentacion);
         for J in 0..Max_Buffer_Col loop
            for I in 1..3 loop
               Goto_Xy(J,I);
               Put(" ");
         end loop;
      end loop;
      
            Goto_Xy(20,2);
      Put("        L A  C L "&í&" N I C A  -  P A C I E N T E S");
        Goto_Xy(23,6);
      Set_Foreground(Light_Red); 
      Set_Background(fondo);
   Put(" SALIDA ");
   end salida_pacientes;
   

   procedure Entrada_pacientes(fondo,Presentacion,                    
         Titulo_Presentacion:Color_type) is 
   begin
               Set_Background(Presentacion);
         Set_foreground(Titulo_Presentacion);
         for J in 0..Max_Buffer_Col loop
            for I in 1..3 loop
               Goto_Xy(J,I);
               Put(" ");
         end loop;
      end loop;
      
            Goto_Xy(20,2);
      Put("        L A  C L I N "&í&" C A  -  P A C I E N T E S");
      Goto_Xy(23,6);
       Set_Background(fondo);
   Set_Foreground(light_blue); 
   Put(" ENTRADA ");
   end Entrada_pacientes;


   procedure Plantilla_Doctor_Paciente (
         fondo,Barra,                           
         Letra_Barra,                                 
         Marco,                           
         Int_Titulo_Izq,                  
         Int_Titulo_Der,                  
         Titulo_Izq,                      
         Titulo_Der,                      
         Int_Izq,                         
         Int_Der             : Color_Type ) is -- ES EL FONDO DISEÑADO PARA UN DOCTOR O PACIENTE

      procedure Barra_Teclas_Paciente_Doctor is 
      begin
         Set_Background(Barra);
         Set_Foreground(Letra_Barra);
         for I in 0..Max_Buffer_Col loop
            Goto_Xy(I,0);
            Put(" ");
         end loop;
         Goto_Xy(1,0);
         Set_Foreground(White);
         Put("ESC = Atr"&Á&"s");

      end Barra_Teclas_Paciente_Doctor;


      Y_Mnj,  
      Y_Dato,  
      Ancho_Cuadro,  
      Ancho_Tit    : Y_Pos;  
      X_Mnj,  
      X_Dato,  
      Largo_Cuadro : X_Pos;  


   begin
    clear_screen(fondo);

      Y_Mnj:=5;
      X_Mnj:=49;

      Y_Dato:=5;
      X_Dato:=4;

      Ancho_Tit:=2;
      Ancho_Cuadro:=13;
      Largo_Cuadro:=44;

      Cuadro(0,4,16,97,Marco);


      Cuadro(X_Dato,Y_Dato,Ancho_Tit,Largo_Cuadro,Marco);

      Cuadro(X_Dato,Y_Dato,Ancho_Cuadro,Largo_Cuadro,Marco);

      Cuadro(X_Mnj,Y_Mnj,Ancho_Cuadro ,Largo_Cuadro,Marco);


      Goto_Xy(X_Dato,Ancho_Tit + Y_Dato);
      Put(Character'Val(204));


      Goto_Xy(X_Dato + Largo_Cuadro,Y_Dato + Ancho_Tit);
      Put(Character'Val(185));

      Goto_Xy(2,1);
      Barra_Teclas_Paciente_Doctor;

      Set_Background(White);
      Set_Foreground(Black);
      for I in 0..Max_Buffer_Col loop
         Goto_Xy(I,21);
         Put(Character'Val(177));
      end loop;

      Goto_Xy(0,0);

   end Plantilla_Doctor_Paciente;





   procedure Plantilla_Tareas_Planificador (
         X              : X_Pos;     
         Y              : Y_Pos;     
         Barra,                      
         C_Tareas,                   
         C_Fondo_Tareas,             
         C_Fondo_Fil,                
         C_Fondo_Col,                
         C_Letra_Fila,               
         C_Letra_Col,                
         C_Col_Mnj,                  
         C_Fondo_Mnj    : Color_Type ) is  -- ES EL FONDO DISEÑADO PARA EL PLANIFICADOR


      procedure Barra_Descripcion is 
      begin

         Goto_Xy(X,Y);
         Set_Background(C_Fondo_Col);
         for I in 0..Max_Buffer_Col loop
            Goto_Xy(X+I,Y);
            Put(" ");
         end loop;
         Set_Foreground(C_Letra_Col);
         Goto_Xy(X,Y);
         Put(" /");
         Goto_Xy(X+5,Y);
         Put("SALA");
         Goto_Xy(Where_X+2,Y);
         Put("NOMBRE");
         Goto_Xy((Where_X - 6) + Tope_Nombre + 2 ,Y);
         Put("APELLIDO");

         Goto_Xy((Where_X - 8) + Tope_Apellido + 2,Y);
         Put("EMERGENCIA");

         Goto_Xy(Where_X + 1,Y)
            ;
         Put("ESPECIALIDAD");

      end Barra_Descripcion;

      procedure Barra_Teclas is 
      begin
         Set_Background(Barra);
         for I in 0..Max_Buffer_Col loop
            Goto_Xy(I,0);
            Put(" ");
         end loop;
         Goto_Xy(1,0);
         Set_Foreground(White);
         Put("ESC = Atr"&Á&"s");
         Goto_Xy((Max_Buffer_Col/2)-5,0);
         Put("LA CL"&í&"NICA");
      end Barra_Teclas;

      procedure Barra_Principal is 
      begin
         Set_Background(C_Fondo_Mnj);
         for J in 0..Max_Buffer_Col loop
            for I in 1..Y-1 loop
               Goto_Xy(J,I);
               Put(" ");
            end loop;
         end loop;

      end Barra_Principal;

      procedure Indices_Filas is 
      begin
         Set_Background(C_Fondo_Fil);
         Set_Foreground(C_Letra_Fila);
         for I in 1..Canti_Salas loop
            Goto_Xy(X,Y+I);
            Put("    ");
            Goto_Xy(X,Y+I);
            Put(I'Img);
         end loop;

      end Indices_Filas;


   begin

      Barra_Principal;
      Barra_Descripcion;
      Indices_Filas;
      Barra_Teclas;
      Goto_Xy(0,0);
   end Plantilla_Tareas_Planificador;


procedure Crear_Menu_Datos_paciente (Menu:out P_L_Menu.T_Lista) is  ----AGREGADO NENEN 19 - 06 - 14
      Reg:T_Menu;
      temp:P_l_menu.T_lista;
   begin
      P_L_Menu.Crear(temp);
      for I in 0..4 loop
         Reg.Indice:=I;
         case I is 
            when 0 => Reg.Titulo(1..6):="Nombre"; -- Poner longitud correcta
               Reg.Long:=6; --poner longitud correcta
            when 1 => Reg.Titulo(1..8):="Apellido";
               Reg.Long:=8;
            when 2 => Reg.Titulo(1..4):="Edad";
               Reg.Long:=4;
            when 3 => Reg.Titulo (1..10):="Emergencia";
               Reg.Long:=10;
            when 4 => Reg.Titulo(1..12):="Especialidad";
               Reg.Long:=12;
         end case;
         P_L_Menu.insertar(temp,Reg);
      end loop;
      P_L_Menu.Crear(menu);
      for I in 0..4 loop
         P_L_Menu.Insertar(Menu,Info(Temp));
         Temp:=P_L_Menu.Siguiente(Temp);
      end loop;
      P_L_Menu.Limpiar(Temp);
   end Crear_Menu_Datos_Paciente;
   

 procedure Crear_Menu_Emergencia (
         Menu :    out P_L_Eme.T_Lista ) is  --AGREGADO NENEN 19 - 06 - 14 

    Reg : P_Menues.T_Menu_Eme;  
   begin
      P_L_Eme.Crear(Menu);
      for I in 0..1 loop
         case I is
            when 0 =>
               Reg.eme(1..2):="SI";
               Reg.Long_eme:=2;
            when 1 =>
               Reg.eme(1..2):="NO";
               Reg.Long_Eme:=2;
            when others =>
               null;
         end case;
         P_L_Eme.Insertar(Menu,Reg);
      end loop;
   end Crear_Menu_Emergencia;
   
   
procedure Crear_Menu_Principal(
         Menu :    out P_L_Menu.T_Lista ) is  -- es un ejemplo de menu.(crear otro y ponerlo en el ads para que sea visible)
      Reg  : T_Menu;  
      Temp : P_L_Menu.T_Lista;  
   begin
      P_L_Menu.Crear(Temp);
      for I in 0..3 loop
         Reg.Indice:=I;
         case I is
            when 0 =>
               Reg.Titulo(1..8):="Doctores"; -- Poner longitud correcta
               Reg.Long:=8; --poner longitud correcta
     