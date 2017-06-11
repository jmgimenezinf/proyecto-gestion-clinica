with P_vec_reducido;

generic
   type Elementomonticulo is private; 
   type Indice is 
         (<>); 

   with function "<" (
         X,                           
         Y : in     Elementomonticulo ) 
     return Boolean; 
   with function ">" (
         X,                           
         Y : in     Elementomonticulo ) 
     return Boolean; 
   with function "<=" (
         X,                           
         Y : in     Elementomonticulo ) 
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


package P_monticulo is

    procedure Get (
         X :    out Elementomonticulo ); 
   procedure Put (
         X : in     Elementomonticulo ); 

   package Vectormonticulo is new P_vec_reducido (
      Elementomonticulo,Indice,Get,put);
      use Vectormonticulo;
      
   subtype Monticulo is Vectormonticulo.T_Vec;
   Raiz: Indice:= Indice'Succ(Indice'First);
   Final: Indice:= Indice'Last;
   procedure Rest_Abajo (
         Vec   : in out Monticulo; 
         Raiz,                     
         Final : in     Indice     ); 
   procedure Rest_Arriba (
         Vec   : in out Monticulo; 
         Final : in out Indice     ); 
   procedure Const_Monticulo (
         Vec   : in out Monticulo; 
         Raiz,                     
         Final : in     Indice     ); 

private
   procedure Intercambiar (
         X,                           
         Y : in out Elementomonticulo ); 

end P_monticulo;
   
