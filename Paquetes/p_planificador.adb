with P_Graficas,Nt_Console,P_Tipos_Datos,Ada.Text_Io,P_Estructura_Clinica,P_Mensajes,Ada.Characters.Handling,P_Acentos;
use p_acentos;

use Nt_Console,P_Tipos_Datos,Ada.Text_Io,P_Estructura_Clinica,Ada.Characters.Handling;


package body P_Planificador is


   package P_Mnj is new P_Mensajes(20,3,40,3,Gray,Gray,Red);
   use P_Mnj;


   procedure Limpiar_Linea (
         Fondo : Color_Type; 
         X     : X_Pos;      
         Y     : Y_Pos       ) is 
   begin
      Goto_Xy(X,Y);
      Set_Background(Fondo);
      Put("                                                                                               ");
   end Limpiar_Linea;

   procedure Imprimir_Paciente (
         Paciente : P_Tipos_Datos.T_Paciente;            
         I        : P_Estructura_Clinica.T_Indice_Salas; especialidad:T_esp;
         X        : X_Pos;                               
         Y        : Y_Pos;                               
         Fondo,                                          
         Letra    : Color_Type                           ) is 
      Com : Integer;  
   begin
      Set_Background(Fondo);
      Set_Foreground(Letra);
      Goto_Xy(X+5,Y);
      Put(I'Img);
      Com:=11;
      Goto_Xy(Com,Y);
      Put(To_Upper(Paciente.Nombre.Nombre(1)));
      Put(to_lower(Paciente.Nombre.Nombre(2..Paciente.Nombre.Long_Nom)));
      Goto_Xy(Com + Tope_Nombre + 2 ,Y);
      Put(To_Upper(Paciente.Nombre.Apellido(1)));
      Put(to_lower(Paciente.Nombre.Apellido(2..Paciente.Nombre.Long_Apell)));
      Goto_Xy(Com + Tope_Apellido + Tope_Nombre + 9,Y);
      if Paciente.Ind_Emergencia then
         Set_Foreground(Red);
         Put("SI");
         Set_Foreground(Black);
      else
         Put("NO");
      end if;
      Goto_Xy(Where_X + 8,Y);
      Put(Especialidad.Esp(1 .. Especialidad.Long));

   end Imprimir_Paciente;




   procedure Imprimir_Siguientes_Pacientes (
         Clinica : in out T_Vec_Salas; 
         Dim     : in out Integer      ) is 
      Paciente : P_Tipos_Datos.T_Paciente;  
   begin
      for I in P_Estructura_Clinica.T_Indice_Salas'range loop
         if not Clinica(I).Sala_Libre then
            if Clinica(I).Disponible then
               if not P_Estructura_Clinica.P_Cola_Espera.Vacia(Clinica(I).Cola_Espera) then
                  Dim:=Dim+1;
                  Siguiente_Paciente (Clinica(I).Cola_Espera,Paciente);
                  Imprimir_Paciente(Paciente,I,Clinica(I).doctor.especialidad,0,Dim,White,Black);
               end if;
            end if;
         end if;
      end loop;

   end Imprimir_Siguientes_Pacientes;



   function Opr_Rta return Character is 
      Rta : Character;  
   begin
      loop
         Get_Immediate (Rta);
         exit when Character'Pos(Rta) = 27 or  Character'Pos(Rta) =13;
      end loop;
      return Rta;
   end Opr_Rta;


   procedure Aplicacion_Planificador (
         Clinica : in out T_Vec_Salas ) is 

      package P_Gra is new P_Graficas (10,2,2,White,White,Gray,Magenta,Gray,White,White,White);
      use P_Gra;

      Dim_Actual,  
      Dim_Com    : Integer;  
      Sala       : Integer;  
   begin
      Clear_Screen(White);
      Plantilla_Tareas_Planificador (
         0,5 ,Cyan,Gray,Magenta,Gray,Black,Black,White,Blue,Gray);
      Set_Foreground(Magenta);
      Set_Background(Gray);
      Goto_Xy(1,3);
      Put("Ingrese el n"&ú&"mero de sala");
      Dim_Com:=5;
      Dim_Actual:=Dim_Com;

      Imprimir_Siguientes_Pacientes(Clinica,Dim_Actual);

      loop
         if Character'Pos(Opr_Rta)=13 then
            Set_Foreground(Black);
            Set_Background(Gray);
            Goto_Xy(1,3);
            Put("Ingrese el n"&ú&"mero de sala                 ");
            Leer_Entero (
               28,3,Sala,3);
            Set_Foreground(Magenta);
            Set_Background(Gray);
            Goto_Xy(1,3);
            Put("Ingrese el n"&Ú&"mero de sala                  ");
            if not (sala = 0) then
            if (Sala>= P_Estructura_Clinica.T_Indice_Salas'Pos(P_Estructura_Clinica.T_Indice_Salas'First)) and (Sala<= P_Estructura_Clinica.T_Indice_Salas'Pos(P_Estructura_Clinica.T_Indice_Salas'Last)) then


               if not Clinica(Sala).Sala_Libre then
                  if not P_Estructura_Clinica.P_Cola_Espera.Vacia(Clinica(Sala).Cola_Espera) then
                     if Clinica(Sala).Disponible then
                        P_Estructura_Clinica.Ingresar_Paciente_Sala(Clinica(Sala));
                        Limpiar_Linea(White,4,Dim_Actual);
                        Dim_Actual:=Dim_Actual -1;
                        Imprimir_Siguientes_Pacientes(Clinica,Dim_Com);
                        Mensaje_Paciente_Ingreso_Sala(30,3);
                     else
                        Mensaje_Sala_No_Valida(40,3);
                     end if;
                  else
                     Mensaje_Sala_No_Valida(40,3);
                  end if;
               else
                  Mensaje_Sala_No_Valida(40,3);

               end if;
            else
               Mensaje_Sala_No_Valida(40,3);
            end if;
         else
            Mensaje_Sala_No_Valida(40,3);
         end if;
         end if;
         


         exit when Character'Pos(Opr_Rta)=27;
      end loop;

   end Aplicacion_Planificador;



end P_Planificador;
