# Discord Go Live
Un script simple para stremear audio en Discord (Linux)

## Disponible en:
馃嚜馃嚫 Espa帽ol

[馃嚭馃嚫 English](README)

___
Como ya deberias saber si usas Discord en Linux, hay un bug con el audio cuando haces stream, y esto no se resuelve ni usando otros clientes no oficiales (ej. Lightcord).

Hay una soluci贸n muy popular en internet en la que mezclas tu audio interno con tu micr贸fono en un nuevo canal de audio virtual, y funciona realmente bien. As铆 que eso es lo que hice: un script que automatiza y simplifica todo este proceso.

![Main menu preview](Screenshot_preview.png "Y as铆 es como se ve")

## Dependencias
* Pulseaudio (para el comando `pactl`)


## Uso
Solo corre el script en una terminal. Despu茅s de iniciar el Go Live, ya puedes compartir tu audio en Discord como si se tratara de tu micr贸fono (por eso, recuerda desmutearte en Discord para transmitir). No se necesitan pasos extra ni instalar nada.

Discord Go Live toma tu salida (sink) y entrada (source) predeterminada para crear la interfaz Virtual1, as铆 que si quieres usar otra entrada/salida modifica la funci贸n `golive` cambiando `@DEFAULT_SINK@` o `@DEFAULT_SOURCE@` por el nombre de tu dispositivo.
(Seguro ya sabes c贸mo hacerlo, pero si no, para obtener los nombres de tus dispositivos de entrada/salida de audio, corre el comando `$ pactl list X` donde X es `sinks` o `sources`, dependiendo de lo que buscas)

Las opciones de mutear/desmutear est谩n inclu铆das por si lo necesitas. No obstante, ten en mente que el script lo mutea al activar la interfaz Virtual1 para que el audio de tu micr贸fono no retorne por tus auriculares.


## Notas adicionales
* Este script no crea nuevos archivos en tu sistema, sino solo en /tmp para almacenar los n煤meros de los modulos de pactl cargados (de forma que este script pueda regresar los cambios en el momento que quieras) en un archivo de texto. De cualquier manera, si pierdes este archivo **los cambios realizados por este script pueden ser revertidos con reiniciar PulseAudio (opci贸n inclu铆da en el menu) o reiniciando el sistema.**
