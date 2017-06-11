
package body P_cola_prioridad is
   ---------------------------------------------------------------------------------------------------------------   
   procedure Inicializar_Prioridad (
         Cola_p : in out T_Cola ) is 
   begin
      Cola_P.Final:= 0;
   end Inicializar_Prioridad;
   ---------------------------------------------------------------------------------------------------------------
   function Vacia (
         Cola_p : T_Cola ) 
     return Boolean is 
   begin
      return Cola_P.Final = 0;
   end Vacia;
   ---------------------------------------------------------------------------------------------------------------
   function Llena (
         Cola_P : T_Cola ) 
     return Boolean is 
   begin
      return Cola_P.Final = Indice'Pos(Indice'Last);
      --Se usa así porque el índice se definde en instanciación
   end Llena;
   ---------------------------------------------------------------------------------------------------------------   
   --Modificación: A los indice'first les agregué un +1 debido que el indice está definido de 0..a max debido 
   --a que el cero debe entrar dentro del tipo para poder compararlo.

   procedure Suprimir (
         Cola_P         : in out T_Cola;     
         Elemento_Prior :    out Elementocola ) is 
      -- quita el elemento de mayor prioridad de la cola y lo devuelve en 
      -- elemento_prior
      -- la cola no esta vacia
   begin
      Elemento_Prior:= Cola_P.Elementos(Indice'First+1);
      Cola_P.Elementos(Indice'First+1):= Cola_P.Elementos(Indice'Val(Cola_P.Final));
      Cola_P.Final:= Cola_P.Final -1;
      Rest_Abajo (Cola_P.Elementos, Indice'First+1, Indice'Val(Cola_P.Final));
   end Suprimir;
   ---------------------------------------------------------------------------------------------------------------
   procedure Insertar (
         Cola_P         : in out T_Cola;     
         Nuevo_Elemento : in     Elementocola ) is 
      Finalindice : Indice;  
   begin
      -- añade Nuevo_Elemento a la cola de prioridad
      -- la cola no esta llena
      Cola_P.Final:= Cola_P.Final +1;--Aumento el tope
      Cola_P.Elementos(Indice'Val(Cola_P.Final)):= Nuevo_Elemento;--Agrego el elemento al final
      Finalindice:= Indice'Val(Cola_P.Final);--Defino el indice final.
      Rest_Arriba (Cola_P.Elementos, Finalindice);--Restauro mandando final.
   end Insertar;
   ---------------------------------------------------------------------------------------------------------------
   
   function Frente (Cola:T_Cola) return elementocola is 
   begin
      return Cola.Elementos(indice'succ(Indice'First));
   end Frente;
   
end  P_cola_prioridad;
