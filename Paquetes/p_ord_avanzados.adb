

package body P_Ord_Avanzados is 
  


procedure Mezclar (Vec:in out T_Vec;Izq_Prim,Izq_Ult,Der_Prim,Der_Ult:Integer) is 
      Temp:T_Vec;
      i,Izq_Actual,Der_Actual:Integer;
      
   begin
      Izq_Actual:=Izq_Prim;
      Der_Actual:=Der_Prim;
      I:= Izq_Prim;
      while (Izq_Actual<=Izq_Ult) and (Der_Actual <=Der_Ult) loop
         if Vec(T_Indice'Val(Izq_Actual)) < Vec(T_Indice'Val(Der_Actual)) then
            Temp(T_Indice'Val(I)):=Vec(T_Indice'Val(Izq_Actual));
            Izq_Actual:=Izq_Actual+1;
         else
            Temp (T_Indice'Val(I)):=Vec(T_Indice'Val(Der_Actual));
            Der_Actual:=Der_Actual+1;
         end if;
         I:=I+1;
      end loop;
      

      while Izq_Actual <= Izq_Ult loop
         Temp(T_Indice'Val(I)):=Vec(T_indice'val(Izq_Actual));
         Izq_Actual:=Izq_Actual+1;
         I:=I+1;
      end loop;
      while Der_Actual <=Der_Ult loop
         Temp(T_Indice'Val(I)):=Vec(T_Indice'Val(Der_Actual));
         Der_Actual:=Der_Actual+1;
         I:=I+1;
      end loop;
      
      for I in T_indice'val(Izq_Prim).. T_indice'val(Der_Ult) loop
         Vec(I):=Temp(I);
      end loop;

   end Mezclar;
   
   
   procedure Sort_Merge(Vec:in out T_Vec;Primero,Ultimo:T_Indice) is    
      Mitad:Integer; 
   begin 
      if T_indice'pos(Primero) < T_indice'pos(Ultimo) then
         Mitad:=(T_indice'pos(Primero) + T_indice'pos(Ultimo))/2;
         Sort_Merge(Vec,Primero,T_indice'val(Mitad));
         Sort_Merge(vec,T_indice'val(Mitad+1),Ultimo);
         Mezclar(Vec,T_indice'pos(Primero),Mitad,Mitad+1,T_indice'pos(Ultimo));
      end if;
     
   end Sort_Merge;

procedure Intercambiar (A,B:in out T_Dato) is 
      Aux:T_Dato;
   begin
      Aux:=A;
      A:=B;
      B:=Aux;
   end Intercambiar;
   
  

   procedure Dividir(Vec:in out T_vec ;Primero,Ultimo:T_indice;Punto_Division:in out t_indice)  is 
   derecha,izquierda:integer;
   v:T_dato;
   begin
      V:=Vec(Primero);
      Derecha:= T_indice'pos(T_indice'succ(Primero));
      Izquierda:=T_indice'pos(Ultimo);
      loop
         while (Derecha<Izquierda) and (Vec(T_indice'val(Derecha))<=V) loop 
            Derecha := derecha + 1 ;
         end loop;
         

         if (Derecha=Izquierda) and (Vec(T_indice'val(Derecha))<=V) then
            Derecha := Derecha + 1  ;
         end if ;
         

         while (Derecha<=Izquierda) and (Vec(T_indice'val(Izquierda))>V) loop
            Izquierda:=izquierda - 1 ;
         end loop;
         
         if Derecha < Izquierda  then
            Intercambiar(Vec(T_indice'val(Derecha)),Vec(T_indice'val(Izquierda)));
            Derecha:=derecha+1 ;
            Izquierda:= Izquierda-1;
         end if;
         exit when Derecha > Izquierda;
      end loop;
      Intercambiar(Vec(primero),Vec(T_indice'val(izquierda)));
      Punto_Division:=T_indice'val(Izquierda);

   end Dividir;

   
   procedure Quicksort(Vec:in out T_Vec;Primero,Ultimo:T_indice) is
      Punto_Division:T_indice; 
   begin
      if Primero<Ultimo then
         Dividir(Vec,Primero,ultimo,Punto_Division);
         if T_indice'pred(punto_division) >= T_indice'first then
            Quicksort(Vec,Primero,T_indice'pred(Punto_Division));
         end if;     
           if T_indice'succ(punto_division) <= T_indice'last then 
            Quicksort(Vec,T_Indice'succ(Punto_Division),Ultimo); 
         end if;
         
      end if;

 


end Quicksort;





   procedure Heapsort (Vec:in out T_Vec;Primero:T_Indice;Ultimo:T_Indice) is 
      Ult_Aux:Integer:=T_Indice'Pos(Ultimo);
   begin 
      Const_Monticulo(Vectormonticulo.T_Vec(Vec),Primero,T_indice'val(ult_aux));
      loop
         Intercambiar(Vec(Primero),Vec(T_indice'val(Ult_aux)));
         ult_aux:= ult_aux-1 ;
         Rest_Abajo(Vectormonticulo.T_Vec(Vec),Primero,T_indice'val(Ult_aux));
         exit when T_Indice'Pos(T_indice'val(Ult_Aux))=1;
   
      end loop;
      
            
         
   end Heapsort;




   
end P_Ord_Avanzados;


