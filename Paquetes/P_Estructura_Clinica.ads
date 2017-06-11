with P_Cola_Prioridad,P_Tipos_Datos;
use P_Tipos_Datos;


package P_Estructura_Clinica is 


   package P_Cola_Espera is new P_Cola_Prioridad(T_Paciente,T_Indice_Cola,">","<","<=","*","/","+","-");
   use P_Cola_Espera;

   type T_Sala is record
   emergencia:boolean;
   Disponible:Boolean:=true; --Indica si está disponible la sala para el siguiente paciente.
   Sala_Libre:Boolean:=true; --Indica si hay un doctor en la sala (si la sala esta ocupada).
   Paciente:T_paciente;    -- Indica el ultimo paciente  atendido por el doctor.
   Doctor:T_Doctor;
   Cola_Espera:P_Cola_Espera.T_Cola; --Una cola de prioridad que contiene los pacientes en espera. El tipo nodo es T_Paciente.
--   Prioridad_Alta:Natural:=0;
--   prioridad_normal:natural:=0;
      Cant_Pacientes:Integer :=0;
      
      
end record;

   subtype T_Indice_Salas is Integer range 1..Canti_Salas; 

type T_Vec_Salas is array (T_indice_salas'range) of T_Sala;


----PARA LA APLICACIÓN DEL DOCTOR 


----ENTRADA

procedure Buscar_Doctor(Salas:T_Vec_Salas;Nom_Doc:T_nombre;Encontrado:out Boolean;Posi:out T_Indice_Salas);

procedure Asignar_Sala_Doctor(Doctor:in T_Doctor;Sala: in out T_Sala); -- Se debe testear antes del llamado que la sala no este ocupada,
   
function Comprobar_Doctor_Sala (Doctor:T_Doctor;Sala:T_Sala) return Boolean; -- Devuelve una variable booleana que indica si el doctor ingresado es igual al que esta en la sala.
----SALIDA

function Haypacientes(Cola:P_Estructura_Clinica.P_Cola_Espera.T_Cola) return boolean ;
 procedure Asignar_Pacientes_Otrosdoc(Salas:in out T_vec_salas;i:T_indice_salas;Hay_Otro:out Boolean); -- el i indica la sala donde esta el doc 

-- IMPRIMIR UN MENSAJE QUE DIGA SE CREO UN ARCHIVO EXEL CON LOS NOMBRES DE LOS PACIENTES Y A QUE DOCTOR TIENE QUE IR .. 

 procedure Quitar_Sala_Doctor(Sala:in out T_Sala);  --Implica poner a sala libre en verdadero.
                                                    --Y poner en blanco sus registros.
                                                    
 




----PARA LA APLICACIÓN DEL PACIENTE.

----ENTRADA

---- Asignacion directa
procedure Buscar_Doctor_Especial(Salas:T_Vec_Salas;Cod_Esp:T_Esp;Emergencia: in boolean;Encontrado:out boolean;Posi:out T_Indice_Salas); --Busca el doctor sugún el codigo de especialidad que menos paciente tiene
--   -- Sino hay asignación directa el parámetro encontrado será falso.
--   

---- Sino hay asignación directa.
Procedure Buscar_Doctor_Adecuado (Paciente:T_Paciente;Salas:T_vec_Salas;Encontrado:out Boolean;Posi:out T_indice_salas); -- Indica a que sala deberá ser atendido el paciente.

procedure Asignar_Doctor_Paciente(Cola_Espera:in out P_Cola_Espera.T_Cola;Paciente:in T_Paciente);-- Implicar meter un paciente a la cola de espera de un doctor
--   --(El doctor será indicado por la busqueda de un doctor adecudo para el paciente).
 
----SALIDA

function Verificar_Paciente_Sala(Sala:T_Sala;Paciente:T_Paciente) return Boolean; --Retorna una variable booleana que indica si el paciente 
--      --ingresado es igual al que esta en la sala.
procedure Quitar_Paciente_Sala(Sala:in out T_Sala); --Implica poner en disponible la sala para el siguiente paciente.
     


----PARA LA APLICACIÓN DEL PLANIFICADOR
--   
procedure Ingresar_Paciente_Sala(Sala:in out T_Sala); -- Ingresar un paciente a la sala de consulta.
--      --implica sacar un paciente de la cola, asignarlo en la sala y poner en falso al campo disponible.


  procedure siguiente_paciente (cola_espera:in out p_cola_espera.t_cola;paciente:out T_paciente); 
procedure Crear_Colas (Salas:in out T_Vec_Salas);


   
   
end P_Estructura_Clinica;

