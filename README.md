Octavian Torcea 324 CA

## `iocla_atoi`:

se verifica prima data daca primul caracter este '-', caz in care se face
variabila 'minus' 1 si se trece la urmatorul caracter. Apoi se scade din
fiecare caracter 48 pana se ajunge la caracterul '\0'. La final, daca variabila
minus e 1, inseamna ca numarul este negativ si se scade de 2 ori din el insusi.

## `create_tree`:

in interiorul acestei functii se apeleaza functia recursiva 'add_node'.
Inainte de a se apela efectiv functia pentru copilul stanga si copilul dreapta,
se apeleaza mai intai strtok pentru a extrage primul simbol (daca e o expresie
valida atunci pe prima pozitie trebuie sa fie mereu un simbol), si se aloca
memorie pentru acesta. La final, in eax se va afla root-ul.

## `add_node`:

functia recursiva ce construieste noduri noi. La fel ca in create_tree,
prima data se apeleaza strtok pentru a obtine noul string, se creeaza noul nod
(se aloca memorie pentru el si pentru char* data), apoi se verifica daca este
simbol sau numar. Daca este numar, recursivitatea se opreste deoarece am ajuns
la frunze. Daca este simbol, se apeleaza iar add_node pentru copilul stanga si
copilul dreapta al nodului nou creat. Functia va returna in ebx nodul creat.
