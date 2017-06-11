with ada.Unchecked_Deallocation;


package body P_Arbol_Bin_Bus is 
   procedure Free is new Ada.Unchecked_Deallocation(T_Nodo,T_Arbol);
   
   procedure Crear(Raiz:out T_Arbol) is 
   begin
      raiz:=null;
   end Crear;
   
   
   function Vacio(raiz:T_Arbol) return Boolean is 
   begin
     return raiz=null;
   end Vacio;
   

   procedure Buscar(Arbol:T_Arbol;Clave:T_clave;Info_Nodo:out T_Elemento;Encontrado:out Boolean) is 
   begin
      if Vacio(Arbol) then 
         Encontrado:=False; 
      else
         if igual_clave(Clave,Info(Arbol)) then
            Encontrado:=True;
            Info_Nodo:=Info(Arbol);
         else 
            if menor_clave(Clave,info(arbol)) then
            Buscar(derecho(arbol),Clave,Info_Nodo,Encontrado);
            else 
            Buscar(Izquierdo(Arbol),Clave,Info_Nodo,Encontrado);
            end if;
         end if;
      end if;
   
   end Buscar;
   



   
   
   procedure Insertar(raiz:in out T_Arbol;Elemento:T_Elemento) is 
      N_Nodo:T_Arbol:=new T_Nodo'(Elemento,null,null);
      Ptr:T_Arbol:=Raiz;
      anterior:T_arbol:=null;
   begin
      while Ptr/=null loop
         Anterior:=Ptr;
         if Ptr.Info>Elemento then
            Ptr:=Ptr.Izq;
         else Ptr:=Ptr.Der;
         end if;
      end loop;
      if Anterior=null then Raiz:=N_Nodo;
      else 
         if Anterior.Info > Elemento then 
            Anterior.Izq:=N_Nodo;
         else 
            Anterior.Der:=N_Nodo;
         end if;
      end if;

   end Insertar;
   


 
   function Izquierdo(Arbol:T_Arbol) return T_Arbol is 
   begin
      return Arbol.Izq;
   end Izquierdo;
   
   function Derecho (Arbol:T_Arbol) return T_Arbol is 
   begin 
      return Arbol.Der;
   end Derecho;
   

   
Procedure Suprimir( Ptr:in out T_Arbol) is 
   Anterior:T_Arbol;
   temp:t_Arbol:=ptr;
begin
   if Ptr.Der = null then 
      Ptr:=Ptr.Izq;
   else
      if  Ptr.Izq = null then 
         Ptr:=Ptr.Der;
      else
       Temp:=ptr.izq;
         Anterior:=Ptr;
         while Temp.Der /= null loop
            Anterior:=temp;
            Temp:=Temp.Der;
         end loop;
         Ptr.Info:=Temp.Info;
         if Anterior = Ptr then
            Anterior.Izq := Temp.Izq ;
         else Anterior.Der:=Temp.Izq;
         end if;
      end if;
   end if;
   Free(Temp);
end Suprimir;


function Esta (Raiz:in T_Arbol ;Buscado:in T_Elemento) return Boolean is 
   Ptr:T_Arbol:=Raiz;
   Valor_En_Arbol:Boolean:= False;
begin
   while Ptr /= null and not Valor_En_Arbol loop
      if Ptr.Info =Buscado then Valor_En_Arbol:= True ;
      else 
         if Ptr.Info > Buscado  then Ptr:=Ptr.Izq;
         else Ptr:=Ptr.Der;
         end if;
      end if;
   end loop;
   Return Valor_En_Arbol;
   end esta;

procedure Limpiar (Ptr:in out T_Arbol) is
begin 
   if not Vacio(Ptr) then
      Limpiar(Ptr.Izq);
      Limpiar(Ptr.Der);
      Free(Ptr);
   end if;
end Limpiar;


   
   procedure Suprimir_En_Arbol(raiz:in out T_Arbol;val_sup:in T_Elemento) is 
      Ptr:T_Arbol:=Raiz;
      anterior:T_arbol;
   begin
      while Ptr.Info/= Val_Sup loop
         Anterior:=Ptr;
         if Ptr.Info > Val_Sup then
            Ptr:=Ptr.Izq;
         else Ptr:=Ptr.Der;
         end if;
      end loop;
      if Ptr=Raiz then Suprimir(Raiz);
      else 
         if Anterior.Izq=Ptr then
            Suprimir(Anterior.Izq);
         else 
            Suprimir(Anterior.Der);
         end if;
      end if;

   end Suprimir_En_Arbol;
   
   procedure Inorden (Ptr:T_Arbol) is
begin
   if Ptr/= null then
      Inorden (Ptr.Izq);
      Put(Ptr.Info);
      Inorden(Ptr.Der);
   end if;
end Inorden;

procedure Preorden (Ptr:in T_Arbol) is
begin
   if Ptr/= null then
      Put(Ptr.Info);
      Preorden(Ptr.Izq);
      Preorden(Ptr.Der);
   end if;
end Preorden;

function Info(Arbol:T_Arbol) return T_Elemento is 
begin
   return Arbol.Info;
end Info;


procedure Posorden(Ptr:in T_Arbol)is
begin
   if Ptr/= null then
      Posorden(Ptr.Izq);
      Posorden(Ptr.Der);
      Put(Ptr.Info);
   end if;
end Posorden;

      

end P_Arbol_Bin_Bus;

