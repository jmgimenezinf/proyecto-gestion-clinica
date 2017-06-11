with P_Graficas,Nt_Console,P_Doctores,P_Estructura_Clinica,p_planificador,p_pacientes;
use Nt_Console,P_Doctores,P_Estructura_Clinica,p_planificador,p_pacientes;



procedure Trabajo_Final_Grupo4 is 

   package P_Gra is new P_Graficas(20,10,10,White,White,White,Light_Blue,Black,Black,Cyan,Black);
   use P_Gra;

   Menu_Principal,  
   Menu_Ent_Sal   :          P_Gra.P_L_Menu.T_Lista;                       --Son listas para manejar el menú.
   Tecla          :          Character;                                    --Para moverme en el seleccionar_dato.
   Clinica        :          T_Vec_Salas;  
   Salir_Mp       :          Boolean;                                      --Es para manejar el menú principal.
   Salir_Es       :          Boolean;  
   Escape         : constant Character              := Character'Val (27);  
   Aux_Menu,  
   Aux_Menu2      :          P_Gra.P_L_Menu.T_Lista;  
begin
   Set_Cursor(False);
   Crear_Menu_Principal(Menu_Principal);
   Crear_Menu_Entrada_Salida(Menu_Ent_Sal);
   Crear_Colas (clinica);
    
   loop--Mp(Menú principal)
      Salir_Mp:=False;--Pongo el controlador en falso.
      Aux_Menu:=Menu_Principal;--Asigno un auxiliar para el seleccionar
      Plantilla_Programa_Principal(Cyan);--Imprimo el fondo
      P_L_Menu.Imprimir(Menu_Principal);--Imprimo el menú.
      --Selecciono.

      loop--No debo dejar que salga con Escape.
         Seleccionar_Dato(10,10,Aux_Menu,Tecla);--La tecla es solo para moverme en el menú.
         exit when Tecla /= Escape;
      end loop;

      case P_Gra.P_L_Menu.Info(Aux_Menu).Indice is--Veo que Funcion realiza.


         when 0 =>--Doctores
              
            loop
                           
               Salir_Es:=False;
               Aux_Menu2:=Menu_Ent_Sal;
               Plantilla_Aplicacion_Doc(Cyan);--Imprimo el fondo
               P_L_Menu.Imprimir(Menu_Ent_Sal);
               loop
                  Seleccionar_Dato(10,10,Aux_Menu2,Tecla);
                  exit when Tecla /= Escape;
               end loop;

               case P_Gra.P_L_Menu.Info(Aux_Menu2).Indice is
                  when 0=>
                                 P_Doctores.Entrada_Doctor(Clinica);
                  when 1=>
                     p_doctores.salida_doctor(clinica);  
                  when 2=>
                     Salir_Es:=True;
                  when others=>
                     null;
               end case;

               exit when Salir_Es;
            end loop;--Doctores

         when 1=>
            loop
               Salir_Es:=False;
               Aux_Menu2:=Menu_Ent_Sal;
               Plantilla_Aplicacion_Pac(Cyan);--Imprimo el fondo
               P_L_Menu.Imprimir(Menu_Ent_Sal);
               loop
                  Seleccionar_Dato(10,10,Aux_Menu2,Tecla);
                  exit when Tecla /= Escape;
               end loop;

               case P_Gra.P_L_Menu.Info(Aux_Menu2).Indice is
                  when 0=>
                     P_pacientes.Entrada_paciente(Clinica);
                  when 1=>
                     p_pacientes.salida_paciente(clinica);  
                  when 2=>
                     Salir_Es:=True;
                  when others=>
                     null;
               end case;

               exit when Salir_Es;
            end loop;--Doctores
         when 2=>--Planificador
           Aplicacion_Planificador(Clinica);
         when 3=>--Salir
            Plantilla_Salida (Cyan);
            Salir_Mp:=True;
            delay 3.0;
         when others =>
            null;
      end case;
      exit when Salir_Mp;
   end loop;

end Trabajo_Final_Grupo4;



