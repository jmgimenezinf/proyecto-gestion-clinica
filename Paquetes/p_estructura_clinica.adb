with P_Tipos_Datos,Ada.Characters.Handling,Excel_Out,Ada.Text_Io;
use P_Tipos_Datos,Ada.Characters.Handling,Excel_Out,Ada.Text_Io;

package body P_Estructura_Clinica is


   procedure Asignar_Sala_Doctor (
         Doctor : in     T_Doctor; 
         Sala   : in out T_Sala    ) is  -- La Sala no debe estar ocupada.
   begin
      if Sala.Sala_Libre then
         Sala.Doctor:=Doctor;
         Sala.Sala_Libre:=False;
      end if;
   end Asignar_Sala_Doctor;


   procedure Quitar_Sala_Doctor (
         Sala : in out T_Sala ) is ----Implica poner a sala libre en verdadero.
   begin
      if not Sala.Sala_Libre then
         Sala.Sala_Libre:=True;
         -------------------------------------------------AGREGUE ESTA PARTE
         Sala.Doctor.Nombre.Nombre:=(others=>' ');
         Sala.Doctor.Nombre.Long_Nom:=0;
         Sala.Doctor.Nombre.Apellido:=(others=>' ');
         Sala.Doctor.Nombre.Long_Nom:=0;
         Sala.Doctor.Especialidad.Esp:=(others=>' ');
         Sala.Doctor.Especialidad.Long:=0;

      end if;

   end Quitar_Sala_Doctor;


   function Comprobar_Doctor_Sala (
         Doctor : T_Doctor; 
         Sala   : T_Sala    ) 
     return Boolean is --Devuelve una variable booleana que indica si el doctor ingresado es igual al que esta en la sala. 
   begin
      if Doctor.Nombre=Sala.Doctor.Nombre then
         if Doctor.Especialidad=Sala.Doctor.Especialidad then
            return True;
         end if;
      end if;

      return False;
   end Comprobar_Doctor_Sala;

   procedure Generar_Exel (
         Sala   : in out T_Sala;                
         Doctor : in     P_Tipos_Datos.T_Doctor ) is 
      Arch_Exel : Excel_Out.Excel_Out_File;  
      I:integer; 
      Paciente  : T_Paciente;  
   begin
      Create(
         Arch_Exel,"Pacientes en espera del doctor "&To_Upper(Doctor.Nombre.Nombre(1..Doctor.Nombre.Long_Nom)) & " "&To_Upper(Doctor.Nombre.Apellido(1..Doctor.Nombre.Long_Apell)) &" .xls",Default_Excel_Type
         );
      for I in 1..5 loop
         case I is
            when 1=>
               Write(Arch_Exel,2,I,"NOMBRE");
            when 2 =>
               Write(Arch_Exel,2,I,"APELLIDO");
            when 3=>
               Write(Arch_Exel,2,I,"EDAD");
            when 4 =>
               Write(Arch_Exel,2,I,"ESPECIALIDAD");
            when 5 =>
               Write(Arch_Exel,2,I,"EMERGENCIA");
         end case;
      end loop;

      I:=1;
      while not P_Cola_Espera.Vacia(Sala.Cola_Espera) loop
         P_Cola_Espera.Suprimir(Sala.Cola_Espera,Paciente);
         for J in 1..5 loop
            case J is
               when 1 =>
                  Paciente.Nombre.Nombre(1):=To_Upper(Paciente.Nombre.Nombre(1));
                  Write(Arch_Exel,I+2,J,Paciente.Nombre.Nombre(1)&To_Lower(Paciente.Nombre.Nombre(2..Paciente.Nombre.Long_Nom)));

               when 2 =>
                  Paciente.Nombre.apellido(1):=To_Upper(Paciente.Nombre.apellido(1));
                  Write(Arch_Exel,I+2,J,Paciente.Nombre.apellido(1)&to_lower(Paciente.Nombre.Apellido(2..Paciente.Nombre.Long_Apell)));
               when 3 =>
                  Write(Arch_Exel,I+2,J,Paciente.Edad);
               when 4 =>
                  Write(Arch_Exel,I+2,J,Paciente.Especialidad.Esp(1..Paciente.Especialidad.Long));
               when 5 =>
                  if Paciente.Ind_Emergencia then
                     Write(Arch_Exel,I+2,J,"SI");
                  else
                     Write(Arch_Exel,I+2,J,"NO");
                  end if;
               when others =>
                  null;
            end case;
         end loop;
         I:=I+1;
      end loop;

      Close(Arch_Exel);

   end Generar_Exel;






   ---- ASIGNAR LOS PACIENTES A OTROS A DOCTORES
   function Haypacientes (
         Cola : P_Estructura_Clinica.P_Cola_Espera.T_Cola ) 
     return Boolean is 
   begin
      return not Vacia(Cola);--agregué el not!

   end Haypacientes;


   ---******* 20-6



   procedure Buscar_Doctor_Especial (
         Salas      :        T_Vec_Salas; 
         Cod_Esp    : in     T_Esp;       
         Emergencia : in     Boolean;     
         --Si es una emergencia.
         Encontrado :    out Boolean;       
         Posi       :    out T_Indice_Salas ) is 
      Canti_Menor : Integer := 0; --Guarda la cantidad menor de pacientes.
      Primero     : Boolean;  
   begin
      Posi:=1;
      Primero:=False;
      Encontrado:=False;
      -------------------------------------------------------------------------------------
      if Emergencia then --Cuando es una emergencia comparo con la cantidad de emergencias.
         for I in T_Indice_Salas loop
            --Busco en la clinica un doctor con la especialidad.
            if not Salas(I).Sala_Libre then
               if Salas(I).Doctor.Especialidad.Esp(1..Salas(I).Doctor.Especialidad.Long) =
                     Cod_Esp.Esp(1..Salas(I).Doctor.Especialidad.Long) --La longitud es la que encuentra en la clinica
                     then
                  --Veo si es el menor.

                  if not Primero then --Veo que no sea el primero
                     Canti_Menor:=Salas(I).Cant_Pacientes;--Si es el primero lo guardo.
                     Posi:=I;--Guardo la posicion del menor.
                     Encontrado:=True;
                     Primero:=True;--Ahora es el primero
                  else
                     if Salas(I).Cant_Pacientes < Canti_Menor then --Si el valor es menor a canti_menor.
                        Canti_Menor:=Salas(I).Cant_Pacientes ;--Cantidad de pacientes sin emergencia.
                        Posi:=I;--Guardo la posicion del menor.
                        Encontrado:=True;
                     end if;
                  end if;
               end if;
            end if;


         end loop;
         ------------------------------------------------------------------------------------------

      else--No es una emergencia.
         for I in T_Indice_Salas loop
            --Busco en la clinica un doctor con la especialidad.
            if not Salas(I).Sala_Libre then
               if Salas(I).Doctor.Especialidad.Esp(1..Salas(I).Doctor.Especialidad.Long) =
                     Cod_Esp.Esp(1..Salas(I).Doctor.Especialidad.Long) --La longitud es la que encuentra en la clinica
                     then
                  --Veo si es el menor.

                  if not Primero then --Veo que no sea el primero
                     Canti_Menor:=Salas(I).Cant_Pacientes;--Si es el primero lo guardo.
                     Posi:=I;--Guardo la posicion del menor.
                     Encontrado:=True;
                     Primero:=True;--Ahora es el primero
                  else
                     if Salas(I).Cant_Pacientes  < Canti_Menor then --Si el valor es menor a canti_menor.
                        Canti_Menor:=Salas(I).Cant_Pacientes ;--Cantidad de pacientes sin emergencia.
                        Posi:=I;--Guardo la posicion del menor.
                        Encontrado:=True;
                     end if;
                  end if;
               end if;
            end if;

         end loop;
      end if;
   end Buscar_Doctor_Especial;


   ---- Sino hay asignación directa.

   procedure Buscar_Doctor_Adecuado (
         Paciente   :        T_Paciente;  
         Salas      :        T_Vec_Salas; 
         Encontrado :    out Boolean;     
         --Esto devuelve si encontro un doctor adecuado.
         Posi :    out T_Indice_Salas ) is  -- Indica a que sala deberá ser atendido el paciente.
      Regi_Aux    : T_Esp;  
      Primero     : Boolean;  
      Canti_Menor : Integer;  
   begin

      Regi_Aux.Esp:="PED ";
      Regi_Aux.Long:=3;

      if Paciente.Edad < 16 then --Busca un pediatra

         Buscar_Doctor_Especial(Salas,Regi_Aux,True,Encontrado,Posi);

      else--Cuando son mayores a 16.
         Regi_Aux.Esp:="MG  ";
         Regi_Aux.Long:=2;

         Buscar_Doctor_Especial(Salas,Regi_Aux,True,Encontrado,Posi);
         --si no hay medicina general 

         if not Encontrado then
            ----------------------
            Regi_Aux.Esp:="PED ";
            Regi_Aux.Long:=3;
            Primero:=False;

            for I in T_Indice_Salas loop
               --Busco en la clinica un doctor con la especialidad.
               if not Salas(I).Sala_Libre then--En una sala ocupada.
                  if Salas(I).Doctor.Especialidad.Esp(1..Salas(I).Doctor.Especialidad.Long) /=
                        Regi_Aux.Esp(1..Salas(I).Doctor.Especialidad.Long) --Es distinto al pediatra.
                        then
                     --Veo si es el menor.

                     if not Primero then --Veo que no sea el primero
                        Canti_Menor:=Salas(I).Cant_Pacientes;--Si es el primero lo guardo.
                        Posi:=I;--Guardo la posicion del menor.
                        Encontrado:=True;
                        Primero:=True;--Ahora es el primero
                     else
                        if Salas(I).Cant_Pacientes < Canti_Menor then --Si el valor es menor a canti_menor.
                           Canti_Menor:=Salas(I).Cant_Pacientes ;--Cantidad de pacientes sin emergencia.
                           Posi:=I;--Guardo la posicion del menor.
                           Encontrado:=True;
                        end if;
                     end if;
                  end if;
               end if;


            end loop;

         end if;
      end if;
   end Buscar_Doctor_Adecuado;


   procedure Asignar_Pacientes_Otrosdoc (
         Salas    : in out T_Vec_Salas;    
         I        :        T_Indice_Salas; 
         Hay_Otro :    out Boolean         ) is  -- el i indica la sala donde esta el doc 
      Var        : T_Indice_Salas;  
   begin
      Buscar_Doctor_Especial (Salas,salas(i).doctor.especialidad,false,Hay_Otro,Var);
      if hay_otro then
         Generar_Exel(Salas(I),Salas(I).Doctor);
      end if;
   end Asignar_Pacientes_Otrosdoc;


   procedure Asignar_Doctor_Paciente (
         Cola_Espera : in out P_Cola_Espera.T_Cola; 
         Paciente    : in     T_Paciente            ) is -- Implicar meter un paciente a la cola de espera de un doctor
      --(El doctor será indicado por la busqueda de un doctor adecudo para el paciente).


   begin
      Insertar(Cola_Espera,Paciente);
   end Asignar_Doctor_Paciente;



   function Verificar_Paciente_Sala (
         Sala     : T_Sala;    
         Paciente : T_Paciente ) 
     return Boolean is  --Retorna una variable booleana que indica si el paciente 
      --      --ingresado es igual al que esta en la sala.

   begin
      return (To_Upper(Sala.Paciente.Nombre.Nombre(1..Sala.Paciente.Nombre.Long_Nom)) =
         To_Upper (Paciente.Nombre.Nombre(1..Paciente.Nombre.Long_Nom) )) and (To_Upper(Sala.Paciente.Nombre.Apellido(1..Sala.Paciente.Nombre.Long_Apell)) =
         To_Upper (Paciente.Nombre.Apellido(1..Paciente.Nombre.Long_Apell) ));
   end Verificar_Paciente_Sala;




   procedure Quitar_Paciente_Sala (
         Sala : in out T_Sala ) is --Implica poner en disponible la sala para el siguiente paciente.

   begin

      if not Sala.Disponible then
         Sala.Disponible:=True;
      end if;
   end Quitar_Paciente_Sala;



   procedure Ingresar_Paciente_Sala (
         Sala : in out T_Sala ) is -- Ingresar un paciente a la sala de consulta.
      --      --implica sacar un paciente de la cola, asignarlo en la sala y poner en falso al campo disponible.

      Paciente : T_Paciente;  
   begin
      if not  P_Cola_Espera.Llena (Sala.Cola_Espera) then
         P_Cola_Espera.Suprimir(Sala.Cola_Espera,Paciente);

         Put (Paciente.Nombre.Nombre(1..Paciente.Nombre.Long_Nom));

         Sala.Paciente.Nombre:=Paciente.Nombre;
         Sala.Paciente.Prioridad:=Paciente.Prioridad;
         Sala.Paciente.Edad:=Paciente.Edad;
         Sala.Paciente.Ind_Emergencia:=Paciente.Ind_Emergencia;
         Sala.Paciente.Especialidad:=Paciente.Especialidad;
         Sala.Disponible:=False;
      else
         null;
      end if;

   end Ingresar_Paciente_Sala;




   procedure Siguiente_Paciente (
         Cola_Espera : in out P_Cola_Espera.T_Cola; 
         Paciente    :    out T_Paciente            ) is 
  
   begin

      Paciente :=P_Cola_Espera.Frente(Cola_Espera);


   end Siguiente_Paciente;


   procedure Buscar_Doctor (
         Salas      :        T_Vec_Salas;   
         Nom_Doc    :        T_Nombre;      
         Encontrado :    out Boolean;       
         Posi       :    out T_Indice_Salas ) is 
      I : T_Indice_Salas;  
   begin
      Encontrado:=False;
      I:=T_Indice_Salas'First;
      while not Encontrado and I<=T_Indice_Salas'Last loop
         if To_Upper(Nom_Doc.Nombre(1..Nom_Doc.Long_Nom))=To_Upper(Salas(I).Doctor.Nombre.Nombre(1..Salas(I).Doctor.Nombre.Long_Nom)) then
            if To_Upper(Nom_Doc.Apellido(1..Nom_Doc.Long_Apell))=To_Upper(Salas(I).Doctor.Nombre.Apellido(1..Salas(I).Doctor.Nombre.Long_Apell)) then
               Posi:=I;
               Encontrado:=True;
            end if;
         end if;
         I:=I+1;
      end loop;

   end Buscar_Doctor;



   procedure Crear_Colas (
         Salas : in out T_Vec_Salas ) is 
   begin
      for I in 1..Canti_Salas loop
         Inicializar_Prioridad (Salas(I).Cola_Espera);
      end loop;
   end Crear_Colas;



end P_Estructura_Clinica;

