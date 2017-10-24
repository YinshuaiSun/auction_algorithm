# auction_algorithm
Algorítmo de leilão
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Stela Carneiro Espíndola  %%
%  Implemetação do algoritmo de leilão (Bertsekas)

% a -> matriz de beneficios
% e -> constante não nula
% alocacao_pessoas -> vetor de alocacao pessoas->objetos
% alocacao_objeto -> vetor de alocacao pessoas<-objetos

% Entrada: matriz beneficio -> a (todos os valores positivos)
%          qtd_pessoas -> numero de linhas de a
%          qnt_objetos -> numero de colunas de a

% Se o objetivo é encontrar o mínimo, a matriz a deve ser multiplicada por
% -1, e o valor total tambem deve ser multiplicado por -1

function leilao(qtd_pessoas, qtd_obj, a)
    e = 0.1;
    preco_obj = zeros(1, qtd_obj); % [0 0 0]
    total = 0;
    if(qtd_pessoas ~= qtd_obj)
        conserta_a(qtd_pessoas, qtd_obj, a);
    end
    %No inicio, nenhuma pessoa é alocada para nenhum objeto
    alocacao_pessoa = zeros(1, qtd_pessoas);

    %Enquanto existirem pessoas ou objetos nao alocados
    cont = 1;
    while (find(~alocacao_pessoa))
        
        fprintf('Iteracao: %d \n' ,cont);
        cont = cont+1;
        for i=1:qtd_pessoas
            %b -> coluna com os valores de i para cada obj
            b = a(i,:)-preco_obj;
            [maior,j] = max(b);
            %v -> o maior valor do objeto
            v = maior;
            b(j) = min(a(:))-1;
            [maior,wj] = max(b);
            %w -> segundo maior valor
            w = maior;
            %y -> ganho do objeto
            y = v-w+e;
            %novo preco do objeto
            preco_obj(1,j) = preco_obj(1,j) + y;
            %se o objeto j já foi alocado, encontra quem estava com ele
            k = alocacao_pessoa==j;
            %desaloca a pessoa k
            alocacao_pessoa(1,k) = 0; 
            %aloca o objeto j para pessoa i
            alocacao_pessoa(1,i) = j;   

            alocacao_pessoa
        end
    end
    fprintf('Alocação Final: \n');
    for i=1:qtd_pessoas
        total = total + a(i, alocacao_pessoa(i));
        fprintf('(%d, %d)\n',i, alocacao_pessoa(i));
    end
    fprintf('Benefício total: %d\n',total);
end

function a = conserta_a(qtd_pessoas, qtd_obj, a)
    if(qtd_pessoas > qtd_obj)
        b = zeros(qtd_pessoas, qtd_pessoas);
        for i=1:qtd_obj
            b(:,i) = a(:,i)+1;
        end       
        b(:,qtd_obj) = 1;
    else
        b = zeros(qtd_obj, qtd_obj);
        for i=1:qtd_pessoas
            b(i,:) = a(i,:)+1;
        end
        b(qtd_pessoas,:) = 1;
    end
    a = b;
end
