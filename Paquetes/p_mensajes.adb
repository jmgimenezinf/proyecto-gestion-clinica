--FINALL
with Ada.Text_Io,P_Acentos;
use Ada.Text_Io,P_Acentos;
package body P_Mensajes is
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Cuadrotexto is 
   begin
      Set_Cursor(False);
      Set_Background(Fondo_Mensaje);
      for J in 1..Base loop
         for I in 1..Altura loop
            Goto_Xy(J+Posicion_X,I + Posicion_Y);
            Put(" ");
         end loop;
      end loop;
   end Cuadrotexto;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Limpiarpantalla is 
   begin
      Goto_Xy(Posicion_X,Posicion_Y);
      Set_Background(Fondo_Pantalla);
      for J in reverse 0..Base+3 loop
         for I in 0..Altura loop
            Goto_Xy(J+Posicion_X,I + Posicion_Y);
            Put(" ");
         end loop;
      end loop;
   end Limpiarpantalla;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Mensaje_Sala_Novalida (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);

      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("La sala ingresada no es");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("v"&á&"lida." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Mensaje_Sala_Novalida;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Sala_Ocupada (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);

      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("La sala ingresada esta");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("siendo utilizada" );

      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Sala_Ocupada;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   --MSJ EL DATO ES CORRECTO.
   procedure Msj_Ing_Nom_Ok (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El dato se ingreso");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("correctamente" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Msj_Ing_Nom_Ok;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Ingrese_Nuevamente (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("Por favor , ingrese");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("nuevamente..." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Ingrese_Nuevamente ;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   --MSJ EL DATO NO SE ENCUENTRA EN LA ESTRUCTURA.
   procedure No_Esta_Doctor (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El doctor ingresado");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("no se encuentra" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end No_Esta_Doctor ;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Doc_Salida_Ok (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El doctor fue sacado");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("correctamente..." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Doc_Salida_Ok;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   ----------------------------------  ------------PACIENTES-------------  ----------------------------------  ----------------------------------
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Pac_Salida_Ok (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El paciente fue sacado");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("correctamente..." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Pac_Salida_Ok;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Dato_No_Valido (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("Por favor, ingrese un dato v"&Á&"lido." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Dato_No_Valido;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure No_Esta_Paciente (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El paciente ingresado");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("no se encuentra" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end No_Esta_Paciente ;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure No_Ingreso_Dato (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put(" ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("Usted no ingreso ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("ning"&Ú&"n dato. " );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end No_Ingreso_Dato;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure No_Hay_Doctor (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("Lo lamentamos, no hay un doctor " );
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put ("disponible en este momento. " );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end No_Hay_Doctor;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Dato_Ing_Invalido (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El dato ingresado es");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("inv"&á&"lido." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end  Dato_Ing_Invalido;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------

   procedure Sala_Para_Paciente (
         X : X_Pos;  
         Y : Y_Pos;  
         Z : Natural ) is 
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El paciente ser"&Á );
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put ("atendido en la sala nro."&Integer'Image(Z)&".");
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Sala_Para_Paciente ;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure No_Se_Puede_Ir (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("No se puede realizar,");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("no hay reemplazo." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end  No_Se_Puede_Ir;
   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Se_Creo_Planilla (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("Se ha creado un archivo,");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("excel, con los pacientes." );
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+4);
      Put("de la cola." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end  Se_Creo_Planilla;

   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------

   procedure Mensaje_Sala_No_Valida (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  

   begin

      Goto_Xy(X ,Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put ("El n"&Ú&"mero de sala no es correcto" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Goto_Xy(X ,Y);
      Put ("                                      " );

   end Mensaje_Sala_No_Valida;


   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------

   procedure Mensaje_Paciente_Ingreso_Sala (
         X : X_Pos; 
         Y : Y_Pos  ) is 
      Rta : Character;  
   begin

      Goto_Xy(X ,Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put ("El Paciente ha entrado a la sala" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Goto_Xy(X ,Y);
      Put ("                                      " );

   end Mensaje_Paciente_Ingreso_Sala;

   ----------------------------------  ----------------------------------  ----------------------------------  ----------------------------------
   procedure Esta_Atendiendo (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("El doctor ingresado ya");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("se encuentra atendiendo." );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Esta_Atendiendo;




   procedure Paciente_Siendo_Atendido (
         X : X_Pos; 
         Y : Y_Pos  ) is --Da un mensaje al usuario cuando un dato se ingresa correctamente.
      Rta : Character;  
   begin
      Cuadrotexto;
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y);
      Set_Background(Fondo_Mensaje);
      Set_Foreground(Color_Mensaje);
      Put("                      ");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+2);
      Put ("No se puede ir, debe terminar");
      Goto_Xy(X + Posicion_X,Y+ Posicion_Y+3);
      Put("de atender al paciente" );
      loop
         Get_Immediate(Rta);
         exit when True;
      end loop;
      Limpiarpantalla;
      Set_Cursor(True);
   end Paciente_Siendo_Atendido;


end P_Mensajes;
