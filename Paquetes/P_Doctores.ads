with P_Estructura_Clinica,Nt_Console;
use P_Estructura_Clinica,Nt_Console;
--with Ada.Text_Io,Nt_Console,P_Graficas,P_Tipos_Datos,P_Mensajes,P_Menues,p_acentos;
--use Ada.Text_Io,Nt_Console,P_Tipos_Datos,P_Menues,P_Acentos;
--with P_Tipos_Datos;
--use P_Tipos_Datos;

package P_Doctores is
   procedure Entrada_Doctor (
         Clinica : in out T_Vec_Salas ); --Estructura.
   procedure Salida_Doctor (
         Clinica : in out T_Vec_Salas); --Estructura.

   Centrar_X   : constant X_Pos      := 7;  
   Centrar_Y   : constant Y_Pos      := 10;  
   Color_Fondo : constant Color_Type := White; 
   x_msj: constant X_Pos      := 0;  
   Y_msj: constant X_Pos      := 2;  

   subtype T_Ok is String (1..4);
   X_Lec:constant:=23;

end P_Doctores;

