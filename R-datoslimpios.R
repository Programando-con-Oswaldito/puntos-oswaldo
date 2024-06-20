library(tidyverse)
library(rio)
datos <- import("datos_ninos.xlsx", sheet = "resultados")
censo<- import("datos_ninos.xlsx", sheet="censo-oficial")

str(datos)
str(censo)

datos <- datos %>%
  mutate(peso = ifelse(peso > 100, peso / 10, peso))

datos <- datos %>%
  mutate(
    peso = ifelse(is.na(peso), mean(peso, na.rm = TRUE), peso),
    talla = ifelse(is.na(talla), mean(talla, na.rm = TRUE), talla),
    parasitos = ifelse(is.na(parasitos), 0, parasitos)
  )
head(datos,50)

datos2 <- left_join( datos,
                     censo,
                     by = NULL,
                     copy = FALSE,
                     suffix = c(".datos", ".censo"),
                     keep = NULL)

