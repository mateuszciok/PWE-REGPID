%% Skrypt odpowiadaj¹cy za inicjalizacjê obiektów na potrzeby struktury regulacji
% 
% WYWO£YWAÆ TYLKO RAZ!
%
% v00 - 12.08.2016 - mjc
%
%% INICJALIZACJA OBIEKTU WYMIANY INFORMACJI
err_count = 0;
if ~exist('rury', 'var')
    rury = classStanowisko('com4'); 
    
    % pozyacja spoczynkowa
    rury.nest;
    
    % wspó³czynniki dla kryz pomiarowych
    rury.K1 = 2.6;
    rury.K2 = 2.6;
    rury.K3 = 2.6;
    
    pause(0.5);
end
%                     !!!!!TYMCZASOWE DO SPRAWDZENIA INICJALIZACJI OBIEKTÓW
                        K=1; Ti=1; Td=1; Tpr=1; High_lim=100; Low_lim=0; Dir=1;
                        wektorX=[0, 100];
                        wektorY=[0, 100];
% INICJALIZACJA PIDów
PID_grzalka = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);
PID_wentylator = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);

% - Zz1 & Zc1
PID_Z1_T = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);
PID_Z1_F = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);

% - Zz2 & Zc2
PID_Z2_T = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);
PID_Z2_F = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);

% - Zz3 & Zc3
PID_Z3_T = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);
PID_Z3_F = classPID(K, Ti, Td, Tpr, High_lim, Low_lim, Dir);

% INICJALIZACJA SUMATORÓW 

% - Grza³ka
SUMA_G_SP = classSUMA(3, High_lim, Low_lim);
SUMA_G_PV = classSUMA(3, High_lim, Low_lim);
SUMA_G_3 = classSUMA(2, High_lim, Low_lim);

% - Wentylator
SUMA_W_SP = classSUMA(3, High_lim, Low_lim);
SUMA_W_PV = classSUMA(3, High_lim, Low_lim);
SUMA_W_3 = classSUMA(2, High_lim, Low_lim);

% - Zz1 & Zc1
SUMA_Z1_c = classSUMA(2, High_lim, Low_lim);
SUMA_Z1_z = classSUMA(2, High_lim, Low_lim);

% - Zz2 & Zc2
SUMA_Z2_c = classSUMA(2, High_lim, Low_lim);
SUMA_Z2_z = classSUMA(2, High_lim, Low_lim);

% - Zz3 & Zc3
SUMA_Z3_c = classSUMA(2, High_lim, Low_lim);
SUMA_Z3_z = classSUMA(2, High_lim, Low_lim);

% INICJALIZACJA FUNKCJI
% (wektorX oraz wektorY postaci np. [1 2 3 4 5]
FUNC_GRZALKA = classFunkcja(wektorX, wektorY, High_lim, Low_lim);
FUNC_WENTYLATOR = classFunkcja(wektorX, wektorY, High_lim, Low_lim);


% INICJALIZACJA PUSTYCH FUNKCJI - na póŸniejsze potrzeby

% - Grza³ka
FUNC_DUMMY_G = classFunkcja([0 100],[0 100], 100, 0);

% - Wentylator
FUNC_DUMMY_W = classFunkcja([0 100],[0 100], 100, 0);

% - Zz1 & Zc1
FUNC_DUMMY_Z1_c = classFunkcja([0 100],[0 100], 100, 0);
FUNC_DUMMY_Z1_z = classFunkcja([0 100],[0 100], 100, 0);

% - Zz2 & Zc2
FUNC_DUMMY_Z2_c = classFunkcja([0 100],[0 100], 100, 0);
FUNC_DUMMY_Z2_z = classFunkcja([0 100],[0 100], 100, 0);

% - Zz3 & Zc3
FUNC_DUMMY_Z3_c = classFunkcja([0 100],[0 100], 100, 0);
FUNC_DUMMY_Z3_z = classFunkcja([0 100],[0 100], 100, 0);

clear K Ti Td High_lim Low_lim Dir wektorX wektorY;

%% ========================================================================
%                              HMI
%  ========================================================================
%% Zmienne pod SetPointy zadawane z Panelu HMI
T1_SP = 25.5;
T2_SP = 26.0;
T3_SP = 28.1;

F1_SP = 13;
F2_SP = 16;
F3_SP = 11;

% temperatura panuj¹ca w otoczeniu
Tamb = 24;

%% Zmienne pod ProcessValue wyœwietlane na panelu HMI
T1_PV = 0; T2_PV = 0; T3_PV = 0;
F1_PV = 0; F2_PV = 0; F3_PV = 0;

%% strukturki do wymiany informacji o nastawach PIDów z HMI
HMI_temp = 0;

HMI_PID_wentylator = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);
HMI_PID_grzalka = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);

% - Zz1 & Zc1
HMI_PID_Z1_T = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);
HMI_PID_Z1_F = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);

% - Zz2 & Zc2
HMI_PID_Z2_T = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);
HMI_PID_Z2_F = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);

% - Zz3 & Zc3
HMI_PID_Z3_T = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);
HMI_PID_Z3_F = struct('reTune',0,'K',0,'Ti',0,'Td',0,'Tpr',0);
