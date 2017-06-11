with ada.Unchecked_Deallocation;



package body P_L_Doble_Enlazada is 
   procedure Liberar is new Ada.Unchecked_Deallocation(T_Nodo,T_Lista);
   

 procedure Crear(Lista:out T_Lista) is 
   begin
      Lista:=null;
   end Crear;
   
   function Vacia(Lista:T_lista) return Boolean is
   begin
      return Lista=null;
   end Vacia;


   function Siguiente(Lista:T_Lista) return T_Lista is 
   begin
         return Lista.Sig;    
   end Siguiente;

   function Info(Lista:T_Lista) return T_Elemento is 
   begin
      return Lista.Info;
   end Info;
   


   function Anterior(Lista:T_Lista) return T_Lista is 
   begin
         return Lista.ant;      
   end anterior;


 
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
 

   procedure Ver(Lista:T_lista;Elemento:out T_Elemento) is  
   begin
      if Lista/= null then Elemento:=Lista.Info; 
      else raise Lista_Vacia;
      end if;
   end Ver;
    

   procedure Imprimir(Lista:T_Lista) is 
      Temp:T_Lista:=Lista;
      y:Y_pos;
   begin
      Y:=0;
      Set_Foreground(Color_Titulo);
      set_background(Color_fondo);
      if Vacia(Lista) then
         raise Lista_Vacia;
      else     
         while Temp/=null loop
            goto_xy(centrar_x,centrar_y+y);
            put(Temp.Info);
            Temp:=Temp.Sig;
            y:=y+1;
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
      N_Nodo:T_Lista:=new T_nodo'(elemento,null,null);
   begin
      if Vacia(Lista) then Lista:=N_Nodo;
      else 
         N_Nodo.Sig:=Lista;
         Lista.Ant:=N_Nodo;
         Lista:=N_Nodo; 
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
   
         
         
      
         



end P_L_Doble_Enlazada;

