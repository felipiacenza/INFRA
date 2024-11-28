#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t ip, m1, f1, ed, m2, f2, paM2, paEd, bdd, rc, rcF2, rcPa, so, soPa, soRc, is, si, siRc, siBd, iaPa, iaM2, cgPa, cgF2, dwRc, dwBd, sdSo, sdRc, bdBdd, bdM2, roF2, roPa, csSo, csSi, aaPa, aaM2;

void* introduccionProgramacion(void * x) {
    printf("Introducción a la Programación\n");
    sem_post(&ed);
}

void* matematica1(void * x) {
    printf("Matemática 1\n");
    sem_post(&m2);
}

void* fisica1(void * x) {
    printf("Física 1\n");
    sem_post(&f2);
}

void* estructuraDatos(void * x) {
    sem_wait(&ed);
    printf("Estructura de Datos\n");
    sem_post(&paEd);
    sem_post(&bdd);
}

void* matematica2(void * x) {
    sem_wait(&m2);
    printf("Matemática 2\n");
    sem_post(&paM2);
    sem_post(&iaM2);
    sem_post(&bdM2);
    sem_post(&aaM2);
}

void* fisica2(void * x) {
    sem_wait(&f2);
    printf("Física 2\n");
    sem_post(&rcF2);
    sem_post(&cgF2);
    sem_post(&roF2);
}

void* programacionAvanzada(void * x) {
    sem_wait(&paEd);
    sem_wait(&paM2);
    printf("Programación Avanzada\n");
    sem_post(&rcPa);
    sem_post(&soPa);
    sem_post(&is);
    sem_post(&iaPa);
    sem_post(&cgPa);
    sem_post(&roPa);
    sem_post(&aaPa);
}

void* basesDatos(void * x) {
    sem_wait(&bdd);
    printf("Bases de Datos\n");
    sem_post(&siBd);
    sem_post(&dwBd);
    sem_post(&bdBdd);
}

void* redesComputadoras(void * x) {
    sem_wait(&rcPa);
    sem_wait(&rcF2);
    printf("Redes de Computadoras\n");
    sem_post(&soRc);
    sem_post(&siRc);
    sem_post(&dwRc);
    sem_post(&sdRc);
}

void* sistemasOperativos(void * x) {
    sem_wait(&soPa);
    sem_wait(&soRc);
    printf("Sistemas Operativos\n");
    sem_post(&sdSo);
    sem_post(&csSo);
}

void* ingenieriaSoftware(void * x) {
    sem_wait(&is);
    printf("Ingeniería de Software\n");
}

void* seguridadInformatica(void * x) {
    sem_wait(&siRc);
    sem_wait(&siBd);
    printf("Seguridad Informática\n");
    sem_post(&csSi);
}

void* inteligenciaArtificial(void * x) {
    sem_wait(&iaPa);
    sem_wait(&iaM2);
    printf("Inteligencia Artificial\n");
}

void* computacionGrafica(void * x) {
    sem_wait(&cgPa);
    sem_wait(&cgF2);
    printf("Computación Gráfica\n");
}

void* desarrolloWeb(void * x) {
    sem_wait(&dwRc);
    sem_wait(&dwBd);
    printf("Desarrollo Web\n");
}

void* sistemasDistribuidos(void * x) {
    sem_wait(&sdSo);
    sem_wait(&sdRc);
    printf("Sistemas Distribuidos\n");
}

void* bigData(void * x) {
    sem_wait(&bdBdd);
    sem_wait(&bdM2);
    printf("Big Data\n");
}

void* robotica(void * x) {
    sem_wait(&roPa);
    sem_wait(&roF2);
    printf("Robótica\n");
}

void* ciberseguridad(void * x) {
    sem_wait(&csSo);
    sem_wait(&csSi);
    printf("Ciberseguridad\n");
}

void* analisisAvanzado(void * x) {
    sem_wait(&aaPa);
    sem_wait(&aaM2);
    printf("Análisis Avanzado\n");
}

int main() {
   
sem_init(&ip, 0, 1); 
sem_init(&m1, 0, 1);
sem_init(&f1, 0, 1);
sem_init(&ed, 0, 0);
sem_init(&m2, 0, 0);
sem_init(&f2, 0, 0);
sem_init(&paEd, 0, 0);
sem_init(&paM2, 0, 0);
sem_init(&bdd, 0, 0);
sem_init(&rcF2, 0, 0);
sem_init(&rcPa, 0, 0);
sem_init(&soPa, 0, 0);
sem_init(&soRc, 0, 0);
sem_init(&is, 0, 0);
sem_init(&siRc, 0, 0);
sem_init(&siBd, 0, 0);
sem_init(&iaPa, 0, 0);
sem_init(&iaM2, 0, 0);
sem_init(&cgPa, 0, 0);
sem_init(&cgF2, 0, 0);
sem_init(&dwRc, 0, 0);
sem_init(&dwBd, 0, 0);
sem_init(&sdSo, 0, 0);
sem_init(&sdRc, 0, 0);
sem_init(&bdBdd, 0, 0);
sem_init(&bdM2, 0, 0);
sem_init(&roPa, 0, 0);
sem_init(&roF2, 0, 0);
sem_init(&csSo, 0, 0);
sem_init(&csSi, 0, 0);
sem_init(&aaPa, 0, 0);
sem_init(&aaM2, 0, 0);

    pthread_t tip, tmat1, tfis1, ted, tmat2, tfis2, tpa, tbdd, trc, tso, tis, tsi, tia, tcg, tdw, tsd, tbd, tro, tcs, taa;
    pthread_attr_t attr;
    pthread_attr_init(&attr);

    pthread_create(&tip, &attr, introduccionProgramacion, NULL);
    pthread_create(&tmat1, &attr, matematica1, NULL);
    pthread_create(&tfis1, &attr, fisica1, NULL);
    pthread_create(&ted, &attr, estructuraDatos, NULL);
    pthread_create(&tmat2, &attr, matematica2, NULL);
    pthread_create(&tfis2, &attr, fisica2, NULL);
    pthread_create(&tpa, &attr, programacionAvanzada, NULL);
    pthread_create(&tbdd, &attr, basesDatos, NULL);
    pthread_create(&trc, &attr, redesComputadoras, NULL);
    pthread_create(&tso, &attr, sistemasOperativos, NULL);
    pthread_create(&tis, &attr, ingenieriaSoftware, NULL);
    pthread_create(&tsi, &attr, seguridadInformatica, NULL);
    pthread_create(&tia, &attr, inteligenciaArtificial, NULL);
    pthread_create(&tcg, &attr, computacionGrafica, NULL);
    pthread_create(&tdw, &attr, desarrolloWeb, NULL);
    pthread_create(&tsd, &attr, sistemasDistribuidos, NULL);
    pthread_create(&tbd, &attr, bigData, NULL);
    pthread_create(&tro, &attr, robotica, NULL);
    pthread_create(&tcs, &attr, ciberseguridad, NULL);
    pthread_create(&taa, &attr, analisisAvanzado, NULL);


    pthread_join(tip, NULL);
    pthread_join(tmat1, NULL);
    pthread_join(tfis1, NULL);
    pthread_join(ted, NULL);
    pthread_join(tmat2, NULL);
    pthread_join(tfis2, NULL);
    pthread_join(tpa, NULL);
    pthread_join(tbdd, NULL);
    pthread_join(trc, NULL);
    pthread_join(tso, NULL);
    pthread_join(tis, NULL);
    pthread_join(tsi, NULL);
    pthread_join(tia, NULL);
    pthread_join(tcg, NULL);
    pthread_join(tdw, NULL);
    pthread_join(tsd, NULL);
    pthread_join(tbd, NULL);
    pthread_join(tro, NULL);
    pthread_join(tcs, NULL);
    pthread_join(taa, NULL);


    sem_destroy(&ip);
    sem_destroy(&m1);
    sem_destroy(&f1);
    sem_destroy(&ed);
    sem_destroy(&m2);
    sem_destroy(&f2);
    sem_destroy(&paEd);
    sem_destroy(&paM2);
    sem_destroy(&bdd);
    sem_destroy(&rcF2);
    sem_destroy(&rcPa);
    sem_destroy(&soPa);
    sem_destroy(&soRc);
    sem_destroy(&is);
    sem_destroy(&siRc);
    sem_destroy(&siBd);
    sem_destroy(&iaPa);
    sem_destroy(&iaM2);
    sem_destroy(&cgPa);
    sem_destroy(&cgF2);
    sem_destroy(&dwRc);
    sem_destroy(&dwBd);
    sem_destroy(&sdSo);
    sem_destroy(&sdRc);
    sem_destroy(&bdBdd);
    sem_destroy(&bdM2);
    sem_destroy(&roPa);
    sem_destroy(&roF2);
    sem_destroy(&csSo);
    sem_destroy(&csSi);
    sem_destroy(&aaPa);
    sem_destroy(&aaM2);

    return 0;
}
