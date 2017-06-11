with Ada.Text_Io,ada.Characters.Handling;
use ada.Text_IO,ada.Characters.Handling;
package body P_Vec_Reducido is 
   
   procedure Leer(Vec:out T_Vec) is 
   begin

      for I in Vec'range loop

         get(Vec(I));
         skip_line;
      end loop;
   end Leer;
   
   procedure Operador_Rta(Rta:out Character) is 
   begin
      Put("ingresar otro elemento?(S/N)");
      loop
      Get_Immediate(Rta);
         exit when To_Upper(Rta)='S' or To_Upper(Rta)='N';
      end loop;
   end Operador_Rta;
   

   procedure Leer_operador(Vec:out T_Vec;dim:out indice) is 
      Rta:Character;
      i:integer;
   begin
       i:=0;      
      loop
         i:=i+1;
         get(Vec(indice'val(I)));
         Skip_Line;
         operador_rta(rta);
      exit when  indice'last > indice'val(i) or to_upper(rta)='N';
      end loop;
      Dim:=indice'val(I);
 
   end Leer_operador;


   procedure Imprimir(Vec:in T_Vec) is 
   begin
      for I in Vec'range loop
        put(Vec(I));
      end loop;
   end Imprimir;
   
   
end p_vec_reducido;
