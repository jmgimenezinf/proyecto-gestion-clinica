with P_Estructura_Clinica,nt_console;
use P_Estructura_Clinica,nt_console;

package P_Pacientes is 
   
   procedure Entrada_Paciente (Clinica: in out T_Vec_Salas);
   procedure Salida_Paciente (Clinica: in out T_Vec_Salas);
   ----------------------------------------------------------
   Centrar_X: constant X_Pos:=7;
   Centrar_Y:constant Y_Pos:=10;
   Color_Fondo:constant Color_Type:=White;
   subtype T_Ok is String (1..5);
   subtype T_Ok_I is String (1..2);
   
   
   ----------------------------------------------------------
   X_Msj:constant:=0;
   Y_Msj:constant:=2;
   ----------------------------------------------------------
   X_Lec:constant:=23;
end P_Pacientes ;