with Nt_Console,P_Tipos_Datos;
use Nt_console,P_Tipos_Datos;

package P_Menues is 

   Centrar_X:constant x_pos := 10;
   Centrar_Y: constant y_pos:= 5;
   

   type T_Menu is record 
      Indice:Natural;
      Titulo:String(1..60);
      long:natural;
   end record;
   
   type T_Menu_Eme is record    ----AGREGADO NENEN 19 - 06 - 14
      Eme: String (1..T_Eme'Last);
      Long_Eme: Natural;
   end record;
   
   procedure Putmenu(Reg:in T_Menu);
   procedure Putesp(Reg:in T_Esp);
     procedure Puteme(Reg: in T_Menu_Eme); ---AGREGADO NENEN 19 - 06 - 14
   function izq (A,B:T_Menu_Eme)return Boolean;---AGREGADO NENEN 19 - 06 - 14
   function der(A,B:T_Menu_Eme)return Boolean;---AGREGADO NENEN 19 - 06 - 14
   function "<" (A,B:T_Esp)return Boolean;
   function ">"(A,B:T_Esp)return Boolean;
   
   
  

end P_menues;
   

