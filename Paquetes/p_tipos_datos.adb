


package body P_Tipos_Datos is 
   

   function "<" (X,Y: in T_Paciente) return Boolean is 
   begin
      return X.Prioridad<=Y.Prioridad;
   end "<";
   
   function ">" (X,Y: in T_Paciente) return Boolean is 
   begin
      return X.Prioridad>Y.Prioridad;
   end ">";
   
   function "<=" (X,Y: in T_Paciente) return Boolean is 
   begin
   return X.Prioridad <= Y.Prioridad;
   end "<=" ;
   
   function "*" (X: in T_Indice_Cola; Y: in integer) return T_Indice_Cola is 
   begin 
      return X*Y;
   end "*";
   
   function "/" (X: in T_Indice_Cola; Y: in integer) return T_Indice_Cola is
   begin
      return X/Y;
   end "/";
   
   function "+" (X: in T_Indice_Cola; Y: in integer) return T_Indice_Cola is 
   begin
      return X+Y;
   end "+";
   
   function "-" (X: in T_Indice_Cola; Y: in integer) return T_Indice_Cola is 
   begin
      return X-Y;
   end "-";
   
end P_Tipos_Datos;

