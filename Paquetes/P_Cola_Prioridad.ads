with P_monticulo;
generic
   type Elementocola is private; 
   type Indice is 
         (<>); 

   with function "<" (
         X,                      
         Y : in     Elementocola ) 
     return Boolean; 
   with function ">" (
         X,                      
         Y : in     Elementocola ) 
     return Boolean; 
   with function "<=" (
         X,                      
         Y : in     Elementocola ) 
     return Boolean; 
   with function "*" (
         X : in     Indice; 
         Y : in     Integer ) 
     return Indice; 
   with function "/" (
         X : in     Indice; 
         Y : in     Integer ) 
     return Indice; 
   with function "+" (
         X : in     Indice; 
         Y : in     Integer ) 
     return Indice; 
   with function "-" (
         X : in     Indice; 
         Y : in     Integer ) 
     return Indice; 

   package  P_cola_prioridad  is
      
   package Colamonticulo is new P_monticulo (Elementocola,
         Indice,"<",">","<=","*","/","+","-");
         
      use Colamonticulo;
      
   subtype T_Elementos is Colamonticulo.Monticulo;
   type T_Cola is 
      record 
         Elementos : T_Elementos;  
         Final     : Integer;  
      end record; 
   procedure Inicializar_Prioridad (
      Cola_P : in out T_Cola ); 
      
   function Vacia (
         Cola_P : T_Cola ) 
      return Boolean; 
      
   function Llena (
         Cola_P : T_Cola ) 
     return Boolean; 
   procedure Suprimir (
         Cola_p         : in out T_Cola;     
         Elemento_Prior :    out Elementocola ); 
   procedure Insertar (
         Cola_P         : in out T_Cola;     
      Nuevo_Elemento : in     Elementocola ); 
      
   function Frente (Cola:T_Cola) return elementocola;
      
end  P_cola_prioridad ;
