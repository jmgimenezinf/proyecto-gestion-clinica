generic
   type T_Elemento is private;
   with procedure put (X:in T_Elemento);
   with function "<" (A,B:T_Elemento)return Boolean;
   with function ">"(A,B:T_Elemento)return Boolean;
   
package P_L_Doble_Enlazada_ord is 
   

type T_Lista is private;


function Siguiente(Lista:T_Lista) return T_Lista;
function Anterior(Lista:T_Lista) return T_Lista;
function Info(Lista:T_Lista) return T_Elemento;
function Esta(Lista:T_Lista;Elemento:T_Elemento) return Boolean;
function Vacia(Lista:T_Lista) return Boolean;
procedure Ver(Lista:T_Lista;Elemento:out T_Elemento);
procedure Insertar(Lista:in out T_Lista;Elemento:T_Elemento);
procedure Suprimir(Lista:in out T_Lista;Elemento:T_Elemento);
procedure Limpiar(Lista:in out T_Lista);
procedure Crear(Lista:out T_Lista);
procedure Imprimir(Lista:T_Lista);

Lista_Vacia:exception;

private 
   type T_Nodo;
   type T_lista is access T_Nodo;
   type T_Nodo is record 
      Info:T_Elemento;
      Ant:T_Lista;
      Sig:T_Lista;
   end record;
   
end P_L_Doble_Enlazada_ord;