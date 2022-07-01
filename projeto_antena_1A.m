% ******************************************************************
% * 04/06/2021
% * Arquivo parte 1
% * Simulação de transmissão de energia elétrica entre duas antenas 
% * Marco Tulio Masselli Rainho Teixeira
% ******************************************************************


% 1- Definindo a antena 1
r1_int = 0.4; % raio interno, 40 cm
r1_ext = 0.5; % raio externo, 50 cm
n1 = 6; % número de voltas
antena_1 = spiralArchimedean('NumArms', 1, 'Turns', n1, 'InnerRadius', r1_int, 'OuterRadius', r1_ext, 'Tilt', 90,'TiltAxis', 'Y');
figure


% 2- Encontrando a impedância e frequência de ressonância 
f = linspace(15e6,19e6,150)

z_1 = impedance(antena_1, f)
plot(f, imag(z_1))
grid on
xlabel('frequencia [Hz]')
ylabel('impedância imaginária [Ohms]')

% valor de frequência que resulta numa impedância com imaginário nulo, para achar a frequência de ressonanssia
imag(impedance(antena_1, 17.68e6))

% f de ressonancia 17.68 MHz (observado no gráfico, conferido pelo valor encontrado na linha anterior)
% f critica 1.615 MHz (observado no gráfico)
f_ress = 17.68e6
fc = 16.15e6


% 3- Definindo a antena 2
r2_int = 0.4; % raio interno, 40 cm
r2_ext = 0.5; % raio externo, 50 cm
n2 = 6; % número de voltas
antena_2 = spiralArchimedean('NumArms', 1, 'Turns', n2, 'InnerRadius', r2_int, 'OuterRadius', r2_ext, 'Tilt', 90,'TiltAxis', 'Y');

% colocando as antenas no mesmo espaço virtual
la=linearArray('Element', [antena_1, antena_1], 'ElementSpacing', 0.5); 
show(la)


% 4- Obtenção do ganho entre as antenas  
ganhos = sparameters(la, f);


% 5- Visualização do ganho 
rfplot(ganhos,2,1, 'abs')

% Percebemos aqui que a frequência de maior ganho coincide com a frequência de ressonância encontrada no item 2

% 6- Visualização do ganho em funcao da frequencia e da distancia

dist = linspace(0.05, 0.6, 10); % distância, 5 a 60 cm
m = zeros(10,150); % matriz de ganhos

% o loop a seguir nos permite calcular os ganhos das antenas, em função da frequência e distância entre elas.
for j = 1: length(dist)
    la_var = linearArray('Element', [antena_1, antena_1], 'ElementSpacing', dist(j));
    param_var = sparameters(la_var, f);
    ganhos_freq_var = rfplot(param_var,2,1,'abs');
    ganhos_array = ganhos_freq_var.YData;
    m(j,:) = ganhos_array;
end

% plotando o gráfico 3D
mesh(f, dist, m)
xlabel('frequencia [Hz]')
ylabel('distancia [m]')
zlabel('ganho [dB]')


% 7- Corrente ressonante
current(antena_1, f_ress)
% Esse item não pode ser bem aproveitado pelo grupo, já que temos a versão 2020 do MatLab e nosso condutor da antena é quase ideal. Mesmo assim, é
% possível perceber a diferença nas tonalidades da espira, mesmo que a corrente seja altíssima pela resistência quase nula do metal.

% 8- Unindo os modelos
sigma = 24 % O sigma foi encontrado com base em testes de diversos valores, e esse foi o que mais combinou nas frequências crítica e de ressonância.
z_list = [];

% temos aqui uma lista de impedâncias para cada frequência no intervalo estudado, pelo modelo baseado no de um transformador
for n = 1: length(f)
    z_list(n) = sigma^2/(1i*f(n)*sigma/fc + fc*sigma/(1i*f(n))) + 4*f(n)*sigma/fc;
end

plot(f, imag(z_1), f, imag(z_list))
xlabel('frequencia [Hz]')
ylabel('impedância imaginária [Ohms]')
% em azul,a impedância da antena, em vermelho, o modelo de transformador

% Relacionar Mútua com distância
dist = linspace(0.05, 0.6, 50); % 5 a 60 cm

%lista de ganhos na frequência de ressonância para diversas distâncias
ganhos_f_ress = zeros(1,50);
for j = 1: length(dist)
    la_var = linearArray('Element', [antena_1, antena_1], 'ElementSpacing', dist(j));
    param_var = sparameters(la_var, f_ress);
    ganhos_freq_var = rfplot(param_var,2,1,'abs');
    ganhos_array = ganhos_freq_var.YData;
    ganhos_f_ress(1,j) = ganhos_array;
end
%%

% Plotando o gráfico de indutância mútua por distância
hold off
Rc = 1
M = Rc*(ganhos_f_ress).^(1/2)/(f_ress*2*pi())
% Modelo: M = ( Rc * sqrt(G) ) / ( 2 * pi * f )
plot(dist, M)
ylabel('Indutância mútua [H]')
xlabel('Distancia [m]')