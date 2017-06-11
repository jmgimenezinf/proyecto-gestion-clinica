with ada.Unchecked_Deallocation;



package body P_L_Doble_Enlazada_Ord is 
   
   procedure Liberar is new Ada.Unchecked_Deallocation(T_Nodo,T_Lista);
   
   

   function Siguiente(Lista:T_Lista) return T_Lista is 
   begin
         return Lista.Sig;    
   end Siguiente;



   function Anterior(Lista:T_Lista) return T_Lista is 
   begin
         return Lista.ant;      
   end anterior;


 procedure Crear(Lista:out T_Lista) is 
   begin
      Lista:=null;
   end Crear;
   
   function Vacia(Lista:T_lista) return Boolean is
   begin
      return Lista=null;
   end Vacia;

 
   function Esta(Lista:T_Lista;Elemento:T_Elemento) return Boolean is
      Temp: T_Lista := Lista; 
   begin
      if Vacia(Lista) then return False;
         else
 
         while Temp/=null loop
            if Temp.Info=Elemento then
               return True;              
            end if;
            Temp:=Temp.Sig;
         end loop;
         return false;
      end if;
            
   end Esta;
 
   function Info(Lista:T_Lista) return T_Elemento is 
   begin
      return Lista.Info;
   end Info;
   


   procedure Ver(Lista:T_lista;Elemento:out T_Elemento) is  
   begin
      if Lista/= null then Elemento:=Lista.Info; 
      else raise Lista_Vacia;
      end if;
   end Ver;
    

   procedure Imprimir(Lista:T_Lista) is 
      temp:T_Lista:=lista;
   begin
      if Vacia(Lista) then
         raise Lista_Vacia;
      else     
         while Temp/=null loop
            put(Temp.Info);
            temp:=temp.sig;
         end loop;
      end if;
   end Imprimir;
   

   procedure Limpiar(Lista:in out T_Lista) is 
    temp:T_lista:=Lista;
   begin
      
      while Lista/=null loop
         Temp:=Lista;
         Lista:=lista.sig;
         liberar(Temp);
      end loop;
      
   end Limpiar;

   procedure Insertar(Lista:in out T_Lista;Elemento:T_Elemento) is 
      N_Nodo:T_Lista:=new T_Nodo'(Elemento,null,null);
      Encontrado:Boolean;
      temp,ant:T_lista;
   begin
      if Vacia(Lista) then 
         Lista:=n_nodo;
      else 
         if Lista.Info>Elemento then
            N_Nodo.Sig:=Lista;
            lista.ant:=n_nodo;
            Lista:=N_Nodo;
         else
        temp:=lista;
      encontrado:=false;
      while not Encontrado and Temp /= null loop
         if Elemento < temp.info then
            Encontrado:=True;
               else 
                  Ant:=Temp;
                  Temp:=Temp.Sig;                           
         end if;
      end loop;   
  
            if Temp = null then
               Ant.Sig:=N_Nodo;
               N_Nodo.Ant:=Ant;              
            else 
               N_Nodo.Sig:=Temp;
               
               N_Nodo.Ant:=Temp.Ant;
               
               Temp.Ant.Sig:=N_Nodo;
               Temp.Ant:=N_Nodo;    
               
         end if;
             
         end if;
      end if;
      

   end Insertar;
   
   
   procedure Suprimir(Lista:in out T_Lista;Elemento:T_Elemento) is 
     Temp:T_lista:=lista;
   begin
      while Temp.Info /= Elemento loop
         Temp:=Temp.Sig;
      end loop;
      if Temp.Ant = null then
         if temp.Sig/=null then
            temp.Sig.Ant:=null;
         end if;
         Lista:=Temp.Sig;
      else
         Temp.Ant.Sig:=Temp.Sig;
         Temp.Sig.Ant:=Temp.Ant;
      end if;
      Liberar(Temp);
   end Suprimir;


end P_L_Doble_Enlazada_ord;