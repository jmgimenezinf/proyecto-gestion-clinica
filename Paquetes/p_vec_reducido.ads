generic
   type T_Elemento is private;
   type indice is (<>);
   with procedure get(X:out T_Elemento);
   with procedure put(X:T_Elemento);
      
   package P_Vec_Reducido is
      
      type T_Vec is array (Indice'range) of T_Elemento; 
      
      procedure Leer(Vec:out T_Vec);
      procedure Leer_Operador(Vec:out T_Vec;Dim:out Indice);
      procedure Imprimir(Vec:in T_Vec);  

   end P_Vec_Reducido;
   

