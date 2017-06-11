with Ada.Text_Io,P_Tipos_datos;
use ada.Text_IO,P_Tipos_datos;
package body P_Menues is 
   
   procedure Putmenu(reg:in T_Menu) is 
   begin 
      Put(reg.Titulo(1..reg.Long));
   end Putmenu;
   
   procedure Puteme(Reg:in T_Menu_eme) is 
   begin
      Put(Reg.eme(1..Reg.Long_eme));
   end Puteme;
   
   procedure Putesp(Reg:in T_Esp) is 
   begin
      Put(Reg.Esp(1..Reg.Long));
   end Putesp;
   

   function "<" (A,B:T_Esp)return Boolean is 
   begin
      return A.Esp(1..a.Long)< B.Esp(1..b.Long);
   end "<";
   
   
   function ">"(A,B:T_Esp)return Boolean is 
     begin
        return A.Esp(1..a.Long) > B.Esp(1..b.Long);
     end ">";
     
  function izq (A,B:T_Menu_Eme)return Boolean is 
   begin
      return A.Eme(1..a.Long_eme)< B.Eme(1..b.Long_eme);
   end izq;
     
   function Der (A,B:T_Menu_Eme)return Boolean is 
     begin
        return A.eme(1..a.Long_Eme) > B.Eme(1..b.Long_Eme);
     end Der;
   
   
end P_Menues;

