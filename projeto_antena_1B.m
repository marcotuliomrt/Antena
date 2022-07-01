% ******************************************************************
% * 04/06/2021
% * Arquivo parte 2
% * Simulação de transmissão de energia elétrica entre duas antenas 
% * Marco Tulio Masselli Rainho Teixeira
% ******************************************************************

r1_int = 0.4;
r1_ext = 0.5;
n1 = 6;
antena_1 = spiralArchimedean('NumArms', 1, 'Turns', n1, 'InnerRadius', r1_int, 'OuterRadius', r1_ext, 'Tilt', 90,'TiltAxis', 'Y');
figure


% 2- Encontrando a frequência de ressonância 
f = linspace(15e6,19e6,150)
% f de ressonancia 6.439 MHz(de 1e6-10e6)
% f de ressonancia 17.68 MHz
f_ress = 17.68e6
fc = 1.615e7


z_1 = impedance(antena_1, f)
plot(f, imag(z_1))
%hold on
grid on

imag(impedance(antena_1, 17.69e6))


sigma = 24


z_list = []
for n = 1: length(f)
    z_list(n) = sigma^2/(1i*f(n)*sigma/fc + fc*sigma/(1i*f(n))) + 4*f(n)*sigma/fc;
end


hold on 
plot(f, imag(z_list))
hold off


dist = linspace(0.05, 0.6, 10);
ganhos_f_ress = zeros(1,10);
for j = 1: length(dist)
    la_var = linearArray('Element', [antena_1, antena_1], 'ElementSpacing', dist(j));
    param_var = sparameters(la_var, f_ress);
    ganhos_freq_var = rfplot(param_var,2,1,'abs');
    ganhos_array = ganhos_freq_var.YData;
    ganhos_f_ress(1,j) = ganhos_array;
end


Rc = 1
M = Rc*(ganhos_f_ress).^(1/2)/(f_ress*2*pi())
plot(dist, M)
ylabel('Indutância mútua [H]')
xlabel('Distancia [m]')