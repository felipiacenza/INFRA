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

      -- Ejecutar las operaciones
      Semaforo_Unico.Wait;
      if Debug then
         Put_Line("CPU " & Numero'Image & " está ejecutando su sección crítica");
      end if;

      -- Leer el valor inicial desde la memoria (posición 0)
      Memoria.Leer(0, Valor_Memoria);
      A := Valor_Memoria;

      -- Realizar la operación ADD
      if Numero = 1 then
         A := A + 13;
      elsif Numero = 2 then
         A := A + 27;
      end if;

      -- Escribir el resultado de vuelta en la memoria (posición 0)
      Memoria.Escribir(0, A);

      if Debug then
         Put_Line("CPU " & Numero'Image & " escribió en memoria el valor: " & A'Image);
      end if;
      Semaforo_Unico.Signal;
   end CPU;

   -- Declaración de dos CPUs
   CPU_1 : CPU(1);
   CPU_2 : CPU(2);

begin
   -- Inicializar el Semáforo
   Put_Line("Inicializando Semáforo...");
   Semaforo_Unico.Init(1);

   -- Inicializar la memoria compartida (ya está lista al declarar la task)
   Put_Line("Memoria lista para ser utilizada.");

   -- Escribir el valor inicial en la memoria
   Memoria.Escribir(0, 8);

   -- Iniciar las CPUs
   CPU_1.Start;
   CPU_2.Start;

   -- Dejar que las CPUs ejecuten por un tiempo
   delay 2.0;

   -- Leer el resultado final desde la memoria
   declare
      Resultado_Final : Integer;
   begin
      Memoria.Leer(0, Resultado_Final);
      Put_Line("Resultado final en la memoria: " & Resultado_Final'Image);
   end;

end Main;