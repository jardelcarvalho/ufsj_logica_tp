funcionario(tecnico,rogerio).
funcionario(tecnico, ivone).

funcionario(engenheiro, daniel).
funcionario(engenheiro, isabel).
funcionario(engenheiro, oscar).
funcionario(engenheiro, tomas).
funcionario(engenheiro, ana).

funcionario(analista, _).
funcionario(supervisor, luis).
funcionario(supervisor, sonia).

funcionario(diretor, santiago).
funcionario(secretaria, laura).

chefe(sonia).


chefiado(Y, X) :- funcionario(engenheiro, X), funcionario(tecnico, Y).
chefiado(Y, X) :- funcionario(supervisor, X), \+chefe(X), funcionario(engenheiro, Y).
chefiado(Y, X) :- funcionario(supervisor, X), \+chefe(X), funcionario(analista, Y).
chefiado(Y, X) :- funcionario(supervisor, X), chefe(X), funcionario(supervisor, Y), \+chefe(Y).
chefiado(Y, X) :- funcionario(diretor, X), funcionario(supervisor, Y), chefe(Y).
chefiado(Y, X) :- funcionario(diretor, X), funcionario(secretaria, Y).


%a
chefe_chefe(Chefe1, Chefe2) :- funcionario(tecnico, Z), chefiado(Z, Chefe1), chefiado(Chefe1, Chefe2).

%b
chefe_ivone(Nome, Cargo) :- chefiado(ivone, Nome), funcionario(Cargo, Nome).

%c
chefiado_supervisor(Pessoa) :- funcionario(supervisor, Y), chefiado(Pessoa, Y).

%d
cargo_carolina(Cargo) :- chefiado(carolina, X), \+funcionario(diretor, X), funcionario(Cargo, carolina).