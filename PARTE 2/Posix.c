#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_MATERIAS 20

typedef enum {
    IP, M1, F1, ED, M2, F2, PA, BD, RC, SO,
    IS, SI, IA, CG, DW, SD, BG, RO, CS, AA
} Materia;

const char* materias[] = {
    "Introducción a la Programación", "Matemáticas I", "Física I", "Estructuras de Datos",
    "Matemáticas II", "Física II", "Programación Avanzada", "Bases de Datos",
    "Redes de Computadoras", "Sistemas Operativos", "Ingeniería de Software",
    "Seguridad Informática", "Inteligencia Artificial", "Computación Gráfica",
    "Desarrollo Web", "Sistemas Distribuidos", "Big Data", "Robótica",
    "Ciberseguridad", "Análisis de Algoritmos"
};

int dependencias[NUM_MATERIAS][NUM_MATERIAS] = {0};
int pendientes[NUM_MATERIAS] = {0}; 
sem_t semaforos[NUM_MATERIAS]; 

void inicializarDependencias() {
    dependencias[ED][IP] = 1;
    dependencias[M2][M1] = 1;
    dependencias[F2][F1] = 1;
    dependencias[PA][ED] = 1;
    dependencias[PA][M2] = 1;
    dependencias[BD][ED] = 1;
    dependencias[RC][PA] = 1;
    dependencias[RC][F2] = 1;
    dependencias[SO][PA] = 1;
    dependencias[SO][RC] = 1;
    dependencias[IS][PA] = 1;
    dependencias[SI][RC] = 1;
    dependencias[SI][BD] = 1;
    dependencias[IA][PA] = 1;
    dependencias[IA][M2] = 1;
    dependencias[CG][F2] = 1;
    dependencias[CG][PA] = 1;
    dependencias[DW][BD] = 1;
    dependencias[DW][RC] = 1;
    dependencias[SD][SO] = 1;
    dependencias[SD][RC] = 1;
    dependencias[BG][BD] = 1;
    dependencias[BG][M2] = 1;
    dependencias[RO][F2] = 1;
    dependencias[RO][PA] = 1;
    dependencias[CS][SI] = 1;
    dependencias[CS][SO] = 1;
    dependencias[AA][PA] = 1;
    dependencias[AA][M2] = 1;

    for (int i = 0; i < NUM_MATERIAS; i++) {
        for (int j = 0; j < NUM_MATERIAS; j++) {
            if (dependencias[i][j]) {
                pendientes[i]++;
            }
        }
    }
}

void* procesarMateria(void* arg) {
    int id = *((int*)arg);

    for (int i = 0; i < pendientes[id]; i++) {
        sem_wait(&semaforos[id]);
    }

    sleep(1);
    printf("%s completada.\n", materias[id]);

    for (int j = 0; j < NUM_MATERIAS; j++) {
        if (dependencias[j][id]) {
            sem_post(&semaforos[j]);
        }
    }

    return NULL;
}

int main() {
    pthread_t hilos[NUM_MATERIAS];
    int ids[NUM_MATERIAS];

    inicializarDependencias();

    for (int i = 0; i < NUM_MATERIAS; i++) {
        sem_init(&semaforos[i], 0, 0);
    }

    for (int i = 0; i < NUM_MATERIAS; i++) {
        ids[i] = i;
        pthread_create(&hilos[i], NULL, procesarMateria, &ids[i]);
    }

    for (int i = 0; i < NUM_MATERIAS; i++) {
        pthread_join(hilos[i], NULL);
    }

    for (int i = 0; i < NUM_MATERIAS; i++) {
        sem_destroy(&semaforos[i]);
    }

    return 0;
}
