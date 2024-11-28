with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Main is
   -- Definición de constantes globales para la simulación
   Tamanho_Memoria : constant Integer := 127;  -- Memoria de 128 posiciones (0 a 127)
   Debug : constant Boolean := True;           -- Activar mensajes de depuración

   -- Definición del semáforo (para sincronizar CPUs)
   task type Semaforo is
      entry Init (Valor_Inicial : Integer);
      entry Wait;
      entry Signal;
   end Semaforo;

   task body Semaforo is
      S : Integer := 0;
   begin
      loop
         select
            accept Init (Valor_Inicial : Integer) do
               S := Valor_Inicial;
               if Debug then
                  Put_Line("Semaforo inicializado a: " & Valor_Inicial'Image);
               end if;
            end Init;
         or
            when S > 0 =>
               accept Wait do
                  S := S - 1;
                  if Debug then
                     Put_Line("Semaforo decrementado. Valor actual: " & S'Image);
                  end if;
               end Wait;
         or
            accept Signal do
               S := S + 1;
               if Debug then
                  Put_Line("Semaforo incrementado. Valor actual: " & S'Image);
               end if;
            end Signal;
         end select;
      end loop;
   end Semaforo;

   -- Declaración del semáforo único para sincronización de CPUs
   Semaforo_Unico : Semaforo;

   -- Definición de la memoria compartida
   task Memoria is
      entry Escribir (Posicion : in Integer; Valor : in Integer);
      entry Leer (Posicion : in Integer; Valor : out Integer);
   end Memoria;

   task body Memoria is
      Mem : array (0 .. Tamanho_Memoria) of Integer := (others => 0);
   begin
      loop
         select
            accept Escribir (Posicion : in Integer; Valor : in Integer) do
               if Debug then
                  Put_Line("Escribiendo en memoria. Posición: " & Posicion'Image & " Valor: " & Valor'Image);
               end if;
               Mem(Posicion) := Valor;
            end Escribir;
         or
            accept Leer (Posicion : in Integer; Valor : out Integer) do
               Valor := Mem(Posicion);
               if Debug then
                  Put_Line("Leyendo de memoria. Posición: " & Posicion'Image & " Valor: " & Valor'Image);
               end if;
            end Leer;
         end select;
      end loop;
   end Memoria;

   -- Definición de las CPUs
   task type CPU (Numero : Integer) is
      entry Start;
   end CPU;

   task body CPU is
      A : Integer := 0;  -- Acumulador
      IP : Integer := 0; -- Puntero de instrucción
      Valor_Memoria : Integer;
   begin
      accept Start do
         if Debug then
            Put_Line("CPU " & Numero'Image & " iniciada");
         end if;
      end Start;

      loop
         -- Leer la instrucción en la dirección del puntero de instrucción
         Memoria.Leer(IP, Valor_Memoria);
         
         case Valor_Memoria is
            when 1 =>  -- LOAD
               IP := IP + 1;
               Memoria.Leer(IP, Valor_Memoria);
               A := Valor_Memoria;
               if Debug then
                  Put_Line("CPU " & Numero'Image & " ejecutó LOAD. Acumulador: " & A'Image);
               end if;

            when 2 =>  -- STORE
               IP := IP + 1;
               Memoria.Leer(IP, Valor_Memoria);
               Memoria.Escribir(Valor_Memoria, A);
               if Debug then
                  Put_Line("CPU " & Numero'Image & " ejecutó STORE en posición " & Valor_Memoria'Image & " con valor: " & A'Image);
               end if;

            when 4 =>  -- ADD
               IP := IP + 1;
               Memoria.Leer(IP, Valor_Memoria);
               A := A + Valor_Memoria;
               if Debug then
                  Put_Line("CPU " & Numero'Image & " ejecutó ADD. Acumulador: " & A'Image);
               end if;

            when 5 =>  -- SEMINIT (inicializar semáforo)
               IP := IP + 1;
               Memoria.Leer(IP, Valor_Memoria);
               Semaforo_Unico.Init(Valor_Memoria);
               if Debug then
                  Put_Line("CPU " & Numero'Image & " ejecutó SEMINIT con valor: " & Valor_Memoria'Image);
               end if;

            when 99 =>  -- STOP
               if Debug then
                  Put_Line("CPU " & Numero'Image & " ejecutó STOP. Finalizando...");
               end if;
               exit;

            when others =>
               null;
         end case;

         -- Mover el puntero de instrucción
         IP := IP + 1;

         -- Sincronización de la sección crítica
         Semaforo_Unico.Wait;
         -- Acceder a la memoria compartida de forma segura
         Memoria.Leer(1, Valor_Memoria);
         A := Valor_Memoria;
         if Numero = 1 then
            A := A + 13;
         elsif Numero = 2 then
            A := A + 27;
         end if;
         Memoria.Escribir(1, A);
         Semaforo_Unico.Signal;

         delay 0.1;  -- Simular un pequeño retardo en la ejecución
      end loop;
   end CPU;

   -- Declaración de dos CPUs
   CPU_1 : CPU(1);
   CPU_2 : CPU(2);

begin
   -- Inicializar el Semáforo
   Put_Line("Inicializando Semáforo...");
   Semaforo_Unico.Init(1);

   -- Inicializar la memoria compartida con instrucciones y valores
   Put_Line("Memoria lista para ser utilizada.");
   Memoria.Escribir(0, 1);  -- LOAD
   Memoria.Escribir(1, 8);  -- Valor a cargar
   Memoria.Escribir(2, 99); -- STOP

   -- Iniciar las CPUs
   CPU_1.Start;
   CPU_2.Start;

   -- Dejar que las CPUs ejecuten por un tiempo
   delay 2.0;

   -- Leer el resultado final desde la memoria
   declare
      Resultado_Final : Integer;
   begin
      Memoria.Leer(1, Resultado_Final);
      Put_Line("Resultado final en la memoria: " & Resultado_Final'Image);
   end;

end Main;