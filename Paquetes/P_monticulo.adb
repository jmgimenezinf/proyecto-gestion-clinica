 package body P_monticulo is
   ---------------------------------------------------------------------------------------------------------------   
   procedure Intercambiar (
         X,                           
         Y : in out Elementomonticulo ) is 
      Aux : Elementomonticulo;  
   begin
      Aux:=X;
      X:=Y;
      Y:=Aux;
   end Intercambiar;
   ---------------------------------------------------------------------------------------------------------------
   procedure Rest_Abajo (
         Vec   : in out Monticulo; 
         Raiz,                     
         Final : in     Indice     ) is 
      -- restaura la propiedad del orden del montículo, del subárbol que comienza por Raiz
      -- Se supone, cuando se invoca, que la propiedad solo la viola el nodo raiz
      Indice_Raiz  : Indice  := Raiz;  
      Monticulo_Ok : Boolean;               -- si es verdadero, ya está reparado el montículo
      Max_Hijo     : Indice;                -- indice del hijo con indice valor máximo
   begin
      Monticulo_Ok:= False;
      -- procesa hasta que la Raiz está en el lugar correcto 
      while Indice_Raiz * 2 <= Final and not Monticulo_Ok loop
         -- calcula el indice del hijo con mayor valor
         if Indice_Raiz*2 = Final
               then -- existe solamente un nodo hijo    
            Max_Hijo:= Indice_Raiz*2;
         else -- elegir el mayor de los dos hijos
            if Vec(Indice_Raiz*2) > Vec(Indice_Raiz*2+1) then
               Max_Hijo:= Indice_Raiz*2;
            else
               Max_Hijo:= Indice_Raiz*2 +1;
            end if;
         end if;
         -- si la propiedad de monticulo es violada, intercambiar valores
--         if Vec(Indice_Raiz) < Vec(Max_Hijo) then
--            Intercambiar (Vec(Indice_Raiz), Vec(Max_Hijo));
--            Indice_Raiz:= Max_Hijo;
--         else
--            Monticulo_Ok:= True;
--         end if;
     if (Vec(Max_Hijo) < Vec(Indice_Raiz)) then
            Monticulo_Ok:= True;
         else
            Intercambiar (Vec(Indice_Raiz), Vec(Max_Hijo));
            Indice_Raiz:= Max_Hijo; 

         end if;


      end loop;
   end Rest_Abajo;
   ---------------------------------------------------------------------------------------------------------------
   procedure Rest_Arriba (
         Vec   : in out Monticulo; 
         Final : in out Indice     ) is 
      -- restaura la propiedad del orden del montículo.
      -- Supone que en la invocación, la propiedad del orden no se cumple sólo en la posición del nodo
      --hoja final
      Indice_Actual : integer;  
      Indice_Padre  : integer;  
      Monticulo_Ok  : Boolean;       -- si es verdadero, ya está reparado el montículo
   begin
      Monticulo_Ok := False;
      Indice_Actual:= indice'pos(Final);
      Indice_Padre:= Indice_Actual/2;
      -- mover el ultimo elemento del montículo hasta que está en su lugar adecuado del montículo,
      -- Con La Propiedad Del Orden Restaurada
      while (Indice_Actual > indice'pos(Indice'First)) and not Monticulo_Ok loop
         -- comparar nodo actual con su nodo padre
         if not (Vec(indice'val(Indice_Padre)) < Vec(indice'val(Indice_Actual))) then
            Monticulo_Ok:=True;
         else
            -- intercambia valores. Prepara la siguiente iteración
            Intercambiar (Vec(indice'val(Indice_Padre)), Vec(indice'val((Indice_Actual))));
            Indice_Actual:= Indice_Padre;
            Indice_Padre:= Indice_Padre/2;
         end if;
      end loop;
   end Rest_Arriba;
   ---------------------------------------------------------------------------------------------------------------
   procedure Const_Monticulo (
         Vec   : in out Monticulo; 
         Raiz,                     
         Final : in     Indice     ) is 
      I              : Indice;  
      Tope,  
      Indice_No_Hoja : Indice;  
   begin
      Tope:= Final;
      Indice_No_Hoja:= Tope/2;
      I:= Indice_No_Hoja;
      loop
         Rest_Abajo (Vec, I, Tope);
         I:= I-1;
         exit when I < Raiz;
      end loop;
   end Const_Monticulo;
   ---------------------------------------------------------------------------------------------------------------
   

    procedure Get (
          X :    out Elementomonticulo ) is 
    begin
       null;
    end Get;
    
   procedure Put (
         X : in     Elementomonticulo ) is 
   begin
      null;
   end Put;
   
end P_monticulo;
