section .data
    delim db " ", 0
    minus db 0                  ;; daca numarul e pozitiv sau negativ

section .bss
    root resd 1

section .text

extern check_atoi
extern print_tree_inorder
extern print_tree_preorder
extern evaluate_tree

extern strtok
extern malloc
extern strdup

global create_tree
global iocla_atoi

iocla_atoi: 
    push ebp
    mov ebp, esp

    push ebx

    xor eax, eax                ;; aici se stocheaza rezultatul
    xor ecx, ecx
    mov ebx, [ebp + 8]          ;; ebx -> stringul

    cmp byte [ebx], '-'         ;; verificam daca e negativ
    jne work

    mov byte [minus], 1
    inc ebx                     ;; sare peste caracterul '-'

work:
    cmp byte [ebx], 0           ;; daca e 0 inseamna ca s-a terminat
    je verify_minus

    mov ecx, 10
    mul ecx
    xor ecx, ecx
    mov cl, byte [ebx]
    sub ecx, 48
    add eax, ecx
    inc ebx                     ;; trece la urmatorul caracter
    jmp work

verify_minus:
    cmp byte [minus], 1
    jne done
    mov ecx, eax                ;; daca este negativ scad din el rezultatul de
    sub eax, ecx                ;; doua ori
    sub eax, ecx

done:

    pop ebx
    mov dword [minus], 0
    leave
    ret


add_node:
    enter 0, 0

    ;; strtok(NULL, delim)
    push delim
    push dword 0
    call strtok
    add esp, 8

    mov edi, eax

    ;; alocare memorie pentru noul nod
    push dword 12
    call malloc
    add esp, 4

    mov ebx, eax
    mov dword [eax + 4], 0
    mov dword [eax + 8], 0

    ;; alocare si duplicare pentru char* data
    push edi
    call strdup
    add esp, 4

    mov dword [ebx], eax
    mov eax, ebx

    ;; verificare daca e numar sau simbol
    ;; in cazul in care e simbol recursivitatea continua
    ;; daca e numarul evident trebuie sa fie frunza
    cmp byte [edi], 47
    jg number

    cmp byte [edi + 1], 0
    jg number

    push eax

    ;; node->left = add_node
    push eax
    push dword [eax + 4]
    call add_node
    add esp, 4
    pop eax
    mov dword [eax + 4], ebx

    ;; node->right = add_node
    push eax
    push dword [eax + 8]
    call add_node
    add esp, 4
    pop eax
    mov dword [eax + 8], ebx

    pop ebx                     ;; se va returna in ebx nodul rezultat

number:
    leave
    ret


create_tree:
    enter 0, 0
    xor eax, eax
    push ebx

    ;; strtok pentru primul simbol
    push delim
    push dword [ebp + 8]
    call strtok
    add esp, 8

    mov edi, eax

    ;; alocare de memorie (12 bytes) pentru nod
    push dword 12
    call malloc
    add esp, 4

    mov ebx, eax
    mov dword [eax + 4], 0      ;; node->left = null
    mov dword [eax + 8], 0      ;; node->right = null

    ;; strdup pentru simbol
    push edi
    call strdup                 ;; thank god strdup also allocates memory
    add esp, 4
    mov dword [ebx], eax

    mov eax, ebx

    ;; node->left = add_node
    push eax
    push dword [eax + 4]
    call add_node
    add esp, 4
    pop eax
    mov dword [eax + 4], ebx

    ;; node->right = add_node
    push eax
    push dword [eax + 8]
    call add_node
    add esp, 4
    pop eax
    mov dword [eax + 8], ebx

    pop ebx
    leave
    ret
