--Finalisimo
with Nt_Console,P_Menues,P_L_Doble_Enlazada,P_L_Doble_Enlazada_Ord,
   P_Tipos_Datos;
use Nt_Console,P_Menues,P_Tipos_Datos;
generic

   Dim_Cad          : Natural;  
   Centrar_X        : X_Pos;      -- indica la posicion "X" del menu en la pantalla.
   Centrar_Y        : Y_Pos;      -- indica la posicion "X" del menu en la pantalla.
   Fondo_Pantalla   : Color_Type;  
   Fondo_Entrada    : Color_Type; -- Indica el color del fondo en la lectura de cadena en el momento que se lee la cadena.
   Fondo_Salida     : Color_Type; -- Indica el color del fondo en la lectura de cadena despues de haber sido leída.
   Letra_Entrada    : Color_Type; --Indica el color de la letra en la lectura de cadena en el momento que se lee la cadena.
   Letra_Salida     : Color_Type; -- Indica el color de la letra en la lectura de cadena despues de haber sido leída.
   Titulo           : Color_Type; --indica el color del titulo del menu de selección.
   Fondo_Seleccion  : Color_Type; --indica el color del fondo de un dato seleccionado del menu.
   Titulo_Seleccion : Color_Type; -- indica el color del titulo de un dato seleccionado del menu



package P_Graficas is
   -------------------------------------------------------------------------------------------------------------------------
   subtype T_Cad is String(1..Dim_Cad);
   -------------------------------------------------------------------------------------------------------------------------
   package P_L_Menu is new P_L_Doble_Enlazada(P_Menues.T_Menu,
      P_Menues.Putmenu,Centrar_X,Centrar_Y,Titulo,Fondo_Pantalla);
   use P_L_Menu;
   -------------------------------------------------------------------------------------------------------------------------
   package P_L_Esp is new P_L_Doble_Enlazada_Ord(P_Tipos_Datos.T_Esp,
      P_Menues.Putesp,P_Menues."<",P_Menues.">");
   use P_L_Esp;
   -------------------------------------------------------------------------------------------------------------------------

   package P_L_Eme is new P_L_Doble_Enlazada_Ord(P_Menues.T_Menu_Eme,P_Menues.Puteme,P_Menues.Izq,P_Menues.Der);  ----ESTO SE LO AGREGUE PARA EL MENU DE EMERGENCIA
   use P_L_Eme;
   -------------------------------------------------------------------------------------------------------------------------
   Max_Buffer_Col:constant Natural:=98;
   Correr_Izquierda:constant Natural:=0;
   -- Esta constante corre "X" posiciones hacia la izquierda para imprimir la cadena leida.
   --En defecto seria en valor "0".
   -------------------------------------------------------------------------------------------------------------------------
   procedure Leer_Texto (
         Posi_X   : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y   : in     Nt_Console.Y_Pos := Where_Y; 
         Cadena   :    out T_Cad;                       
         Tope     : in     Natural;                     
         Longitud :    out Natural                      );  -- Longitud es igual a cero si ingreso escape o entero al principio.
   -------------------------------------------------------------------------------------------------------------------------
   procedure Leer_Entero (
         Posi_X : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y : in     Nt_Console.Y_Pos := Where_Y; 
         Entero :    out Integer;                     
         Tope   : in     Natural                      );    -- Longitud es igual a cero si ingreso escape o entero al principio.
   -------------------------------------------------------------------------------------------------------------------------
   procedure Leer_Flotante (
         Posi_X   : in     Nt_Console.X_Pos := Where_X; 
         Posi_Y   : in     Nt_Console.Y_Pos := Where_Y; 
         Flotante :    out Float;                       
         Tope     : in     Natural                      );    -- Longitud es igual a cero si ingreso escape o entero al principio.
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Datos (
         Menu :    out P_L_Menu.T_Lista ); 
   -- Crea un menu de datos .(Este debe ser personalizado según el menu que desean crear).
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Datos_Paciente (
         Menu :    out P_L_Menu.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------   
   procedure Datos_Salida_Paciente (
         Menu :    out P_L_Menu.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Emergencia (
         Menu :    out P_L_Eme.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Especialidad (
         Menu :    out P_L_Esp.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------   
   procedure Crear_Menu_Especialidad_Doc (
         Menu :    out P_L_Esp.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Ing_Nom_Doc (
         Menu :    out P_L_Menu.T_Lista ); 

   -------------------------------------------------------------------------------------------------------------------------
   procedure Seleccionar_Dato (
         Centrar_X :        X_Pos;            
         Centrar_Y :        Y_Pos;            
         Datos     : in out P_L_Menu.T_Lista; 
         Tecla     :    out Character         ); 
   --Tecla contiene la tecla enter o escape.La lista Dato esta apuntando al dato seleccionado.
   -------------------------------------------------------------------------------------------------------------------------
   procedure Seleccionar_Especialidad (
         X    :        X_Pos;          
         Y    :        Y_Pos;          
         Menu : in out P_L_Esp.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Seleccionar_Emergencia (
         X    :        X_Pos;          
         Y    :        Y_Pos;          
         Menu : in out P_L_Eme.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Plantilla_Tareas_Planificador (
         X              : X_Pos;     
         Y              : Y_Pos;     
         Barra,                      
         C_Tareas,                   
         C_Fondo_Tareas,             
         C_Fondo_Fil,                
         C_Fondo_Col,                
         C_Letra_Fila,               
         C_Letra_Col,                
         C_Col_Mnj,                  
         C_Fondo_Mnj    : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Plantilla_Doctor_Paciente (
         Fondo,                      
         Barra,                      
         Letra_Barra,                
         Marco,                      
         Int_Titulo_Izq,             
         Int_Titulo_Der,             
         Titulo_Izq,                 
         Titulo_Der,                 
         Int_Izq,                    
         Int_Der        : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Salida_Doctores (
         Fondo,                           
         Presentacion,                    
         Titulo_Presentacion : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Entrada_Doctores (
         Fondo,                           
         Presentacion,                    
         Titulo_Presentacion : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------

   procedure Salida_Pacientes (
         Fondo,                           
         Presentacion,                    
         Titulo_Presentacion : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Entrada_Pacientes (
         Fondo,                           
         Presentacion,                    
         Titulo_Presentacion : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------

   procedure Crear_Menu_Principal (
         Menu :    out P_L_Menu.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Crear_Menu_Entrada_Salida (
         Menu :    out P_L_Menu.T_Lista ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Plantilla_Programa_Principal (
         Fondo : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------   
   procedure Plantilla_Aplicacion_Doc (
         Fondo : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------   
   procedure Plantilla_Aplicacion_Pac (
         Fondo : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Plantilla_Entrada_Salida (
         Fondo : Color_Type ); 
   -------------------------------------------------------------------------------------------------------------------------
   procedure Plantilla_Salida (
         Fondo : Color_Type ); 



   -- REFERENCIAS DE PARÁMETROS:

   -- Posi_x: indica la posicion "X" del Cursor en la pantalla.(Este valor se debe inicializar).
   -- Posi_y: Indica la posicion "Y" del Cursor en la pantalla. (Este valor se debe inicializar).

   -- "posi_x" y "posi_y" deben ser valores desde la posición donde se quiera leer en pantalla.

   -- Fondo_Entrada : Indica el color del fondo en la lectura de cadena en el momento que se lee la cadena.(Este valor se debe inicializar).
   -- Fondo_Salida :  Indica el color del fondo en la lectura de cadena despues de haber sido leída.(Este valor se debe inicializar). 

   -- Letra_Entrada:  Indica el color de la letra en la lectura de cadena en el momento que se lee la cadena.(Este valor se debe inicializar). 
   -- Letra_Salida:  Indica el color de la letra en la lectura de cadena despues de haber sido leída.(Este valor se debe inicializar). 

   --Cadena: Es la cadena ingresada por el usuario.
   --Tope : Es el tope de la lectura de cadena.(El usuario no podrá ingresar mas carácteres que dicho tope).
   --Longitud: Es la de la cadena ingresada por el usuario.

   --Entero : Es el valor entero ingresado por el usuario.
   --Flotante :Es el valor flotante ingresado por el usuario.




end P_Graficas ;

   
