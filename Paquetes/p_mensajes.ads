---FINAL

with Nt_Console;
use Nt_Console;


generic
   Posicion_X     : X_Pos;      -- Posiciona el "x" del cuadro de mensaje.
   Posicion_Y     : Y_Pos;      -- Posiciona el "x" del cuadro de mensaje.
   Base           : Natural;    -- Es la dimension de la base del cuadro de mensaje.
   Altura         : Natural;    -- Es la dimension de la altura del cuadro de mensaje.
   Fondo_Pantalla : Color_Type; -- Es el color de fondo de la pantalla.
   Fondo_Mensaje  : Color_Type; -- Es el color de fondo del cuadro de mensaje.
   Color_Mensaje  : Color_Type; -- Es el color del mensaje

package P_Mensajes is


   procedure Mensaje_Sala_Novalida (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Msj_Ing_Nom_Ok (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure No_Esta_Doctor (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Ingrese_Nuevamente (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Doc_Salida_Ok (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Pac_Salida_Ok (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Sala_Ocupada (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Dato_No_Valido (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure No_Ingreso_Dato (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure No_Esta_Paciente (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Dato_Ing_Invalido (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Se_Creo_Planilla (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure No_Se_Puede_Ir (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure No_Hay_Doctor (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Sala_Para_Paciente (
         X : X_Pos;  
         Y : Y_Pos;  
         Z : Natural ); 

   procedure Mensaje_Sala_No_Valida (
         X : X_Pos; 
         Y : Y_Pos  ); 
   procedure Mensaje_Paciente_Ingreso_Sala (
         X : X_Pos; 
         Y : Y_Pos  ); 

  procedure Esta_atendiendo(
         X : X_Pos; 
         Y : Y_Pos  ); 
  procedure Paciente_siendo_atendido  ( X : X_Pos; 
         Y : Y_Pos  );

end P_Mensajes; 
   

