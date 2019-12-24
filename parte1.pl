%a
%Consulta ex.: insere_final(4, [1, 2, 3], L).
%Função: insere elemento no final da lista
%Parâmetros
%  E: elemento
%  P: lista antiga
%  Q: lista nova
%Retorno: lista com elemento inserido
insere_final(E, [], [E]). %Fim da lista, insere E no final
insere_final(E, [H|P], [H|Q]) :- insere_final(E, P, Q). %Lista não vazia. Continua a extrair a cabeça de P e enfileirar para Q

%b
%consulta ex.: insere_pos(1, 2, [1, 2, 3, 4], L).
%Função: insere elemento na posição
%Parâmetros
%  E: elemento
%  Pos_i: posição
%  P: lista antiga
%  Q: lista nova
%Retorno: lista com elemento inserido
insere_pos(E, 0, P, [E|P]). %Contador é zero. Posição para inserir E
insere_pos(E, Pos_i, [H|P], [H|Q]) :- Pos_j is Pos_i - 1, insere_pos(E, Pos_j, P, Q). %Contador não é zero. Continua quebrando P e sub. o contador

%c
%Consulta ex.: remove_pos(2, [1, 2, 3, 4], L).
%Função: remove elemento da posição
%Parâmetros
%  Pos_i: posição
%  P: lista antiga
%  Q: lista nova
%Retorno: lista com elemento removido
remove_pos(0, [_|P], P). %Contador é zero. Abster da cabeça de P
remove_pos(Pos_i, [H|P], [H|Q]) :- Pos_j is Pos_i - 1, remove_pos(Pos_j, P, Q). %Contador não é zero. Continua quebrando P e sub. o contador

%d
%Consulta ex.: intersecao([1, 2, 3, 3, 4], [1, 3, 3], L).
%Função: interseção de duas listas
%Parâmetros
%  E: elemento
%  P: lista antiga
%  Q: lista nova
%Retorno: resultado da interseção (sem duplicações)
intersecao([], _, []). %Lista base vazia. Não há mais elementos para verificar interseção
intersecao([H|P], Q, [H|R]) :- membro(H, Q), \+membro(H, P), intersecao(P, Q, R). %Lista base não vazia. Se membro(...) e ~membro(...) garante a interseção de P e Q sem repetições em R
intersecao([_|P], Q, R) :- intersecao(P, Q, R). %Entra neste caso em ocasiões que não há a necessidade de verificar interseção

%e
%Consulta ex.: esta_contido([1, 2, 4], [1, 2, 3, 4]).
%Função: verifica se o conjunto P está contido em Q
%Parâmetros
%  P: conjunto
%  Q: conjunto
%Retorno: verdadeiro se estiver contido, caso contrário, falso 
esta_contido([], _). %Lista vazia. O conjunto então está contido
esta_contido([H|P], Q) :- membro(H, Q), esta_contido(P, Q). %Lista não vazia. Ainda verificando se é membro(...)
false/0. %Se um elemento de P não estiver contido em Q então não está contido

%f
%Consulta ex.: maior([1, 20, 3, 4], M).
%Função: Recolhe o maior elemento da lista
%Parâmetros
%  P: lista
%  N: maior elemento
%Retorno: maior elemento da lista
maior([M], M). %Comparou todos. O maior elemento está em M
maior([H|P], M) :- maior(P, N), (H > N -> M = H ; M = N). %Não comparou todos. Se H > N, H se torna o maior, caso contrário N

%g 
%Consulta ex.: ordena([1,3,5,2,4],S).
%Função: Ordena um vetor de números
%Parâmetros
%  Z: Lista
%  S: Lista ordenada
%Retorno: uma lista de números ordenados
ordena([], []).
ordena([X], [X]).
ordena([X,Y|Z], S) :- distribui([X,Y|Z], A, B), ordena(A, V), ordena(B, T), intercala(V, T, S).

%h
%Consulta ex.: soma_n(3, S).
%Função: soma os N primeiros números naturais
%Parâmetros:
%  N_i: N
%  S: soma dos N termos
%Retorno: a soma 
soma_n(0, 0).
soma_n(N_i, S) :- N_j is N_i - 1, soma_n(N_j, R), S is R + N_i.

%i
%Consulta ex.: palindromo([a, r, a, r, a]).
%Função: verifica se uma lista é um palíndromo
%Parâmetros:
%  X: lista
%Retorno: verdadeiro se for um palíndromo, falso caso contrário
palindromo(X) :- inverte(X, I), I = X. %Verifica se X-invertido é igual a X

%j
%Consulta ex.: acomoda([a, [a, [b, c]], b, [c, d]], L).
%Função: transforma uma lista de listas em uma lista de uma dimensão.
%Parâmetros:
%  P: lista de listas
%  Q: lista resultante
%Retorno: uma lista de uma dimensão.
acomoda([], []). %Abriu toda a lista, retorna uma lista vazia.
acomoda([[H|T]|P], Q) :- concatena(T, P, R), acomoda([H|R], Q). %A cabeça é uma lista. Concatenar as duas T e P, após isso reinserir a cabeça e realizar nova chamada acomoda/2. 
acomoda([H|P], [H|R]) :- acomoda(P, R). %A cabeça é um elemento. Chamar acomoda para a cauda.


%funções auxiliares
concatena([], Q, Q).
concatena([H|P], Q, S) :- concatena(P, Q, R), insere_pos(H, 0, R, S).

inverte([H|P], R) :- inverte_aux(P, [H], R).
inverte_aux([], Q, Q).
inverte_aux([H|P], Q, R) :- inverte_aux(P, [H|Q], R).

membro(E, [E|_]).
membro(E, [_|L]) :- membro(E, L).

distribui([], [], []).
distribui([X], [X], []).
distribui([X,Y|Z], [X|A], [Y|B]) :- distribui(Z, A, B).

intercala([], B, B).
intercala(A, [], A).
intercala([X|A], [Y|B], [X|C]) :- X =< Y, intercala(A, [Y|B], C).
intercala([X|A], [Y|B], [Y|C]) :- X > Y, intercala([X|A], B, C).