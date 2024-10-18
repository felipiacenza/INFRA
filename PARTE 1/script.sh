#!/bin/bash

usuario_unico() {
    if grep -q "^$1" admins.txt || grep -q "^$1" clients.txt; then
        return 1
    else
        return 0
    fi
}

registrar_usuario() {
    while true; do
        echo "Registrar usuario"
        read -p "Ingrese nuevo usuario: " newUser
        if usuario_unico "$newUser"; then
            break
        else
            clear
            echo "El usuario ya existe, por favor elija otro nombre."
            sleep 3
            clear
        fi
    done
    echo
    read -s -p "Ingrese su contraseña: " newPass
    echo
    read -p "Tipo de usuario: admin o cliente [A/C]: " userType

    while true; do
        echo
        if [[ "$userType" == 'A' || "$userType" == 'a' ]]; then
            clear
            echo "Usuario $newUser creado con éxito. El usuario es de tipo: Administrador"
            echo -e "$newUser $newPass" >>admins.txt
            sleep 3
            break
        elif [[ "$userType" == 'C' || "$userType" == 'c' ]]; then
            echo -e "$newUser $newPass" >>clients.txt
            echo "----------------------------------------------"
            echo "Usuario $newUser creado con éxito. El usuario es de tipo: Cliente"
            echo "----------------------------------------------"
            sleep 3
            break
        else
            echo "Has ingresado mal el tipo de usuario, intente de nuevo."
            read -p "Tipo de usuario: admin o cliente [A/C]: " userType
        fi
    done
    menu_admin
}

mascota_unica() {
    if grep -q "^$1" mascotas.txt; then
        return 1
    else
        return 0
    fi
}

validarMascotaEdad() {
    while true; do
        read -p "Edad: " petAge
        if [[ $petAge > 0 ]]; then
            break
        else
            clear
            echo "Ingrese una edad mayor a 0."
            sleep 3
            clear
        fi
    done
}

registrar_mascota() {
    echo "Registrar mascota"
    # Ingresar ID (número positivo y único)
    while true; do
        read -p "Ingrese el número identificador de la mascota: " petId
        if [[ "$petId" =~ ^[0-9]+$ ]]; then # Verifica que sea un número
            if mascota_unica "$petId"; then
                break
            else
                clear
                echo "El número identificador ya fue asignado, por favor elija otro número."
                sleep 3
                clear
            fi
        else
            clear
            echo "Por favor, ingrese un número válido."
            sleep 3
            clear
        fi
    done

    # Ingresar tipo
    read -p "Ingrese tipo de mascota: " petType

    # Ingresar nombre
    read -p "Nombre de la mascota: " petName

    # Ingresar sexo (solo acepta "macho" o "hembra")
    while true; do
        read -p "Sexo (macho/hembra): " petSex
        if [[ "$petSex" == "macho" || "$petSex" == "hembra" ]]; then
            break
        else
            clear
            echo "Ingrese un sexo válido (macho/hembra)."
            sleep 3
            clear
        fi
    done

    # Ingresar edad (debe ser mayor a 0)
    while true; do
        read -p "Edad: " petAge
        if [[ "$petAge" =~ ^[0-9]+$ && $petAge -gt 0 ]]; then
            break
        else
            clear
            echo "Ingrese una edad válida mayor a 0."
            sleep 3
            clear
        fi
    done

    # Ingresar descripción
    read -p "Descripción: " petDescription

    # Guardar mascota en archivo
    echo "$petId - $petType - $petName - $petSex - $petAge - $petDescription" >>mascotas.txt
    echo "----------------------------------------------"
    echo "Mascota agregada con éxito!"
    echo "----------------------------------------------"
    sleep 3
    clear
    menu_admin
}

estadisticas() {
    estadisticas() {
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)
        ## HECHO CON CHATGPT (ENTENDER SOLUCIÓN Y PLANTEAR OTRAS)

        echo "Generando estadísticas de adopciones..."
        echo "----------------------------------------------"

        # Verificar si hay adopciones registradas
        if [[ ! -s adopciones.txt ]]; then
            echo "No hay adopciones registradas."
            sleep 3
            clear
            menu_admin
        fi

        # Inicializar variables para las estadísticas
        declare -A tipos_de_mascotas
        declare -A adopciones_por_mes
        total_adopciones=0
        suma_edades=0
        total_mascotas_con_edad=0

        # Procesar archivo de adopciones
        while IFS= read -r line; do
            # Ejemplo de formato: "001 - Perro - Rex - Macho - 5 - Juguetón - Fecha de adopción: 15/03/2024"
            tipo_mascota=$(echo "$line" | awk -F ' - ' '{print $2}')
            edad_mascota=$(echo "$line" | awk -F ' - ' '{print $5}')
            fecha_adopcion=$(echo "$line" | awk -F 'Fecha de adopción: ' '{print $2}')
            mes_adopcion=$(echo "$fecha_adopcion" | cut -d '/' -f 2)

            # Contabilizar adopciones por tipo de mascota
            ((tipos_de_mascotas["$tipo_mascota"]++))

            # Contabilizar adopciones por mes
            ((adopciones_por_mes["$mes_adopcion"]++))

            # Sumar edades para calcular promedio
            if [[ "$edad_mascota" =~ ^[0-9]+$ ]]; then
                suma_edades=$((suma_edades + edad_mascota))
                ((total_mascotas_con_edad++))
            fi

            ((total_adopciones++))
        done <adopciones.txt

        # Calcular porcentaje de adopción por tipo de mascota
        echo "Porcentaje de adopción por tipo de mascota:"
        for tipo in "${!tipos_de_mascotas[@]}"; do
            porcentaje=$(echo "scale=2; ${tipos_de_mascotas[$tipo]} * 100 / $total_adopciones" | bc)
            echo "$tipo: $porcentaje%"
        done
        echo "----------------------------------------------"

        # Calcular el mes con más adopciones
        echo "Mes con más adopciones:"
        max_adopciones=0
        mes_mas_adopciones=""
        for mes in "${!adopciones_por_mes[@]}"; do
            if [[ ${adopciones_por_mes[$mes]} -gt $max_adopciones ]]; then
                max_adopciones=${adopciones_por_mes[$mes]}
                mes_mas_adopciones=$mes
            fi
        done
        echo "El mes con más adopciones fue: $mes_mas_adopciones ($max_adopciones adopciones)"
        echo "----------------------------------------------"

        # Calcular la edad promedio de los animales adoptados
        if [[ $total_mascotas_con_edad -gt 0 ]]; then
            promedio_edad=$(echo "scale=2; $suma_edades / $total_mascotas_con_edad" | bc)
            echo "Edad promedio de los animales adoptados: $promedio_edad años"
        else
            echo "No se pudo calcular la edad promedio debido a datos insuficientes."
        fi
        echo "----------------------------------------------"

        echo "(presione cualquier tecla para continuar)"
        read -n 1 -s
        clear
        menu_admin
    }

}

menu_admin() {
    echo "1) Registar un nuevo usuario"
    echo "2) Registrar una mascota nueva"
    echo "3) Estadísticas de adopción"
    echo "4) Salir"

    read -p "Ingrese opción: " op

    case $op in
    1)
        clear
        registrar_usuario
        ;;

    2)
        clear
        registrar_mascota
        ;;

    3)
        estadisticas
        ;;
    4)
        exit # salir
        ;;
    *)
        echo "No es una opción válida"
        sleep 3
        clear
        menu_admin
        ;;
    esac
}

listar_mascotas() {
    echo "Listar mascotas disponibles para adopción"
    echo "----------------------------------------------"

    if [[ ! -s mascotas.txt ]]; then
        echo "No hay mascotas registradas."
        return
    fi

    while IFS= read -r line; do
        echo "$line"
    done <mascotas.txt

    echo "----------------------------------------------"
    echo "(presione cualquier tecla para continuar)"
    read -n 1 -s # Espera a que se presione una sola tecla sin mostrarla
    clear
    menu_cliente
}

procesar_adopcion() {
    while true; do
        # Validar que el número de mascota sea válido
        if [[ $1 =~ ^[0-9]+$ && $1 -le $2 && $1 -gt 0 ]]; then
            # Obtener los datos de la mascota seleccionada
            mascotaAdoptada=$(sed -n "${1}p" mascotas.txt)

            # Confirmar adopción
            nombreMascota=$(echo "$mascotaAdoptada" | awk -F ' - ' '{print $2}')
            read -p "¿Está seguro de que desea adoptar a $nombreMascota (sí/no)? " confirmacion

            if [[ "$confirmacion" == "sí" || "$confirmacion" == "si" ]]; then
                # Obtener la fecha actual
                fecha=$(date +'%d/%m/%Y')

                # Registrar adopción en el archivo
                echo "$mascotaAdoptada - Fecha de adopción: $fecha" >>adopciones.txt

                # Eliminar la mascota de la lista de adopciones usando sed
                sed -i "${1}d" mascotas.txt
                clear
                echo "----------------------------------------------"
                echo "¡Adopción realizada con éxito!"
                echo "----------------------------------------------"
                break
            else
                echo "Adopción cancelada."
                break
            fi
        else
            # Si el número ingresado no es válido
            echo "----------------------------------------------"
            echo "Selección inválida. Por favor, ingrese un número entre 1 y $2 o 0 para regresar al menú."
            echo "----------------------------------------------"
            sleep 2
            read -p "Ingrese nuevamente el número de la mascota o 0 para volver al menú: " nuevoNumero

            # Regresar al menú si se ingresa 0
            if [[ "$nuevoNumero" == "0" ]]; then
                clear
                return # Regresar al menu
            fi

            numeroSeleccionado="$nuevoNumero" # Ya ingresa el nuevo numero para la siguiente iteración del while
        fi
    done
}

adoptar_mascota() {
    echo "Adoptar mascota"
    echo "----------------------------------------------"

    # Verificar si el archivo de mascotas está vacío
    if [[ ! -s mascotas.txt ]]; then
        echo "No hay mascotas registradas."
        sleep 3
        menu_cliente
    fi

    # Listar las mascotas disponibles
    i=1
    while IFS= read -r line; do
        echo "$i) $line"
        ((i++))
    done <mascotas.txt
    totalMascotas=$(($i - 1)) # Total de mascotas listadas

    echo "----------------------------------------------"

    # Ingresar número de la mascota y validar
    while true; do
        read -p "Ingrese el número de la mascota que desea adoptar (o 0 para regresar al menú): " mascotaSeleccionada
        case $mascotaSeleccionada in
        0)
            # Si es 0, regresar al menú del cliente
            clear
            menu_cliente
            return
            ;;
        *)
            # Procesar la adopción
            procesar_adopcion $mascotaSeleccionada $totalMascotas
            break
            ;;
        esac
    done
    menu_cliente
}

menu_cliente() {
    echo "1) Listar mascotas disponibles"
    echo "2) Adoptar mascota"
    echo "3) Salir"

    read -p "Ingrese opción: " op

    case $op in
    1)
        clear
        listar_mascotas
        ;;

    2)
        clear
        adoptar_mascota
        ;;

    3)
        exit # salir
        ;;
    *)
        echo "No es una opción válida"
        sleep 3
        clear
        menu_cliente
        ;;
    esac
}

check_pass() {
    while true; do
        clear
        read -s -p "Ingrese su contraseña: " pass_ingresada
        echo
        if [[ "$pass_ingresada" == "$pass" ]]; then
            clear
            echo "----------------------------------------------"
            echo "Acceso concedido"
            echo "Rol: $1"
            echo "----------------------------------------------"
            sleep 3
            clear
            break
        else
            echo "Contraseña incorrecta. Inténtelo de nuevo."
            sleep 3
        fi
    done

    if [[ "$1" == "administrador" ]]; then
        menu_admin
    else
        menu_cliente
    fi
}

ingresar_usuario() {
    while true; do
        clear
        read -p "Ingrese su usuario: " username
        tipo_client=$(grep "^$username " clients.txt)
        tipo_admin=$(grep "^$username " admins.txt)

        if [[ -n $tipo_client ]]; then
            rol="cliente"
            pass=$(echo $tipo_client | cut -d ' ' -f2)
            break
        elif [[ -n $tipo_admin ]]; then
            rol="administrador"
            pass=$(echo $tipo_admin | cut -d ' ' -f2)
            break
        else
            echo "Usuario no encontrado."
            sleep 3
        fi
    done

    check_pass $rol
}

incio() {
    clear
    echo "Bienvenido al sistema!"
    ingresar_usuario
}

incio
