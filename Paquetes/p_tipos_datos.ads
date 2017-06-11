

package P_Tipos_Datos is 
   
   --*****************************************/
   --CONSTANTES
 
   Max_Priori_Alta: constant Natural := 1;  -- Maximo de pacientes en emergencia
   Max_Priori_Normal: constant Natural := 2;   -- Maximo de pacientes con prioridad normal.
   Tope_Emergencia: constant Natural :=2; --Maximo de cadena SI / NO
   Tope_Especialidad: constant Natural :=4; -- Maximo de cadena de especialidad.
   Tope_Nombre: constant Natural := 30;  -- Maximo cadena de un nombre.
   Tope_Pacientes:constant Natural := 30;
   Tope_Apellido:constant Natural :=30;  -- Maximo cadena de un apellido.
   Canti_Salas:constant Natural :=100; --En caso de modificacion de las salas.
      
   --*****************************************/
   

   subtype T_Cad_Esp is String(1..Tope_Especialidad);
   
   type T_Esp is record 
      Esp:T_cad_esp:=(others=>' ');
      Long:Natural:=0;
   end record;

      
   type T_Indice_Salas is new Natural range 1.. Canti_Salas;
   subtype T_Eme is String (1..Tope_Emergencia); --EMERGENCIA SI NO... 19 - 06 - 14


   type T_Nombre is record
      Nombre:String(1..Tope_Nombre):=(others=>'@');
      long_nom:natural:=0;
      Apellido:String(1..Tope_Apellido):=(others=>'@');
      long_apell:natural:=0;
   end record;
   

type T_Paciente is record
   Prioridad:natural;
   Nombre:T_Nombre;
   Edad:Natural;--De 1 a 100.
   Especialidad:T_Esp;
   Ind_Emergencia:Boolean;
end record;
   
type T_Doctor is record
   Nombre:T_Nombre;
   Numero_Sala: T_indice_salas ; --De 1 a 100. Se consiste con la constante canti_sala.
   Especialidad:T_Esp; -- Se consiste con el tope especialidad.
end record;

-- Operaciones para instanciar el paquete de cola de prioridad.

type T_indice_cola is range 0..Tope_pacientes;

  function "<" (X,Y: in T_Paciente) return Boolean;
  function ">" (X,Y: in T_Paciente) return Boolean; 
  function "<=" (X,Y: in T_Paciente) return Boolean;
  function "*" (X: in T_Indice_cola; Y: in integer) return T_Indice_cola;  
  function "/" (X: in T_Indice_cola; Y: in integer) return T_Indice_cola;
  function "+" (X: in T_Indice_cola; Y: in integer) return T_Indice_cola;
  function "-" (X: in T_Indice_cola; Y: in integer) return T_Indice_cola;

end P_Tipos_Datos;

