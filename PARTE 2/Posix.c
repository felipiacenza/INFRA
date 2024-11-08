#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

sem_t ip, m1, f1, ed, m2, f2, pa, paM2, paEd, bdd, rc, rcF2, rcPa, so, soPa, soRc, is, si, siRc, siBd, ia, iaPa, iaM2, cg, cgPa, cgF2, dw, dwRc, dwBd, sd, sdSo, sdRc, bd, bdBdd, bdM2, ro, roF2, roPa, cs, csSo, csSi, aa, aaPa, aaM2;

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
    sem_init(&pa, 0, 0);
    sem_init(&bdd, 0, 0);
    sem_init(&rc, 0, 0);
    sem_init(&so, 0, 0);
    sem_init(&is, 0, 0);
    sem_init(&si, 0, 0);
    sem_init(&ia, 0, 0); 
    sem_init(&cg, 0, 0);
    sem_init(&dw, 0, 0);
    sem_init(&sd, 0, 0);
    sem_init(&bd, 0, 0);
    sem_init(&ro, 0, 0);
    sem_init(&cs, 0, 0);
    sem_init(&aa, 0, 0);

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
    sem_destroy(&pa);
    sem_destroy(&bdd);
    sem_destroy(&rc);
    sem_destroy(&so);
    sem_destroy(&is);
    sem_destroy(&si);
    sem_destroy(&ia);
    sem_destroy(&cg);
    sem_destroy(&dw);
    sem_destroy(&sd);
    sem_destroy(&bd);
    sem_destroy(&ro);
    sem_destroy(&cs);
    sem_destroy(&aa);

    return 0;
}
