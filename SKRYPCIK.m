%% Skrypt opisuj¹cy strukturê regulacji
% 
%
% v00 - 12.08.2016 - mjc
%
%% ZACZYTANIE POMIARÓW Z PRZETWORNIKÓW
[opStatusFT1, inputStateFT1] = rury.GetFT1();
[opStatusFT2, inputStateFT2] = rury.GetFT2();
[opStatusFT3, inputStateFT3] = rury.GetFT3();
            
[opStatusTT1, inputStateTT1] = rury.GetTT1();
[opStatusTT2, inputStateTT2] = rury.GetTT2();
[opStatusTT3, inputStateTT3] = rury.GetTT3();
[opStatusTTout, inputStateTTout] = rury.GetTTout();

if opStatusFT1 ~= 0 || opStatusFT2 ~= 0 || opStatusFT3 ~=0 || opStatusTT1 ~=0 || opStatusTT2 ~=0 || opStatusTT3 ~=0 || opStatusTTout ~= 0
    %WYST¥PI£ B£¥D
    err_count = err_count + 1;
    tmp = sprintf('Wystapil b³¹d odczytu z ModBusa! \n statusy: FT1: %d FT2: %d FT3: %d TT1: %d TT2: %d TT3: %d TTout: %d',opStatusFT1, opStatusFT2, opStatusFT3, opStatusTT1, opStatusTT2, opStatusTT3, opStatusTTout);
    disp(tmp);
    disp(err_count);
    
    error_info = 1;
else
    F1_PV = inputStateFT1;
    F2_PV = inputStateFT2;
    F3_PV = inputStateFT3;
               
    T1_PV = inputStateTT1;
    T2_PV = inputStateTT2;
    T3_PV = inputStateTT3;
    
    Tout_PV = inputStateTTout;
    
    error_info = 0;
end
 

%% OBLICZENIE NA STRUKTURZE REGULACJI
if error_info == 0 % liczymy strukturkê gdy mamy komplet poprawnie odebranych danych - tutaj trzeba bêdzie dopisaæ iloczyn logiczny z jakimœ live-bit'em ze SCADAy lub panela.
    %% strukturka dla grza³ki
    %
    % wêze³ sumacyjny 1 - wartoœci SetPoint
    SUMA_G_SP.licz([F1_SP*( T1_SP - Tamb ), F2_SP*( T2_SP - Tamb ), F3_SP*( T3_SP - Tamb )]);
    % wêze³ sumacyjny 2 - wartoœci ProcessValue
    SUMA_G_PV.licz([F1_PV*( T1_PV - Tamb ), F2_PV*( T2_PV - Tamb ), F3_PV*( T3_PV - Tamb )]);
    
    % funkcja dopasowuj¹ca
    FUNC_GRZALKA.licz(SUMA_G_SP.output);
    
    % wyliczenie nowego sterowania
    PID_grzalka.calc(SUMA_G_PV.output, SUMA_G_SP.output);
    
    % suma 3
    SUMA_G_3.licz([FUNC_GRZALKA.output, PID_grzalka.output]);
    
    % "pusta" funkcja - na wypadek potrzeb w przysz³oœci
    FUNC_DUMMY_G.licz(SUMA_G_3.output);
    
    % sterowanie dla grza³ki
    G_val = FUNC_DUMMY_G.output;
    
    %% strukturka dla wentylatora
    %
    % wêze³ sumacyjny 1 - wartoœci SetPoint
    SUMA_W_SP.licz([F1_SP, F2_SP, F3_SP]);
    % wêze³ sumacyjny 2 - wartoœci ProcessValue
    SUMA_W_PV.licz([F1_PV, F2_PV, F3_PV]);
    
    % funkcja dopasowuj¹ca
    FUNC_WENTYLATOR.licz(SUMA_W_SP.output);
    
    % wyliczenie nowego sterowania
    PID_wentylator.calc(SUMA_W_PV.output, SUMA_W_SP.output);
    
    % suma 3
    SUMA_W_3.licz([FUNC_WENTYLATOR.output, PID_wentylator.output]);
    
    % "pusta" funkcja - na wypadek potrzeb w przysz³oœci
    FUNC_DUMMY_W.licz(SUMA_W_3.output);
    
    % sterowanie dla wentylatora
    W_val = FUNC_DUMMY_W.output;
    
    %% strukturka dla zaworów Zz1 & Zc1
    %
    % regulator PID od temperatury
    PID_Z1_T.calc(T1_PV, T1_SP);
    
    % regulator PID od przep³ywu
    PID_Z1_F.calc(F1_PV, F1_SP);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza zimnego
    SUMA_Z1_z.licz([PID_Z1_T.output, PID_Z1_F.output]);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza ciep³ego
    SUMA_Z1_c.licz([100 - PID_Z1_T.output, PID_Z1_F.output]);
    
    % "pusta" funkcja - na wypadek potrzeb w przysz³oœci
    FUNC_DUMMY_Z1_c.licz(SUMA_Z1_c.output);
    FUNC_DUMMY_Z1_z.licz(SUMA_Z1_z.output);
    
    % sterowanie dla zaworów
    Zz1_val = FUNC_DUMMY_Z1_z.output;
    Zc1_val = FUNC_DUMMY_Z1_c.output;
    
    %% strukturka dla zaworów Zz2 & Zc2
    %
    % regulator PID od temperatury
    PID_Z2_T.calc(T2_PV, T2_SP);
    
    % regulator PID od przep³ywu
    PID_Z2_F.calc(F2_PV, F2_SP);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza zimnego
    SUMA_Z2_z.licz([PID_Z2_T.output, PID_Z2_F.output]);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza ciep³ego
    SUMA_Z2_c.licz([100 - PID_Z2_T.output, PID_Z2_F.output]);
    
    % "pusta" funkcja - na wypadek potrzeb w przysz³oœci
    FUNC_DUMMY_Z2_c.licz(SUMA_Z2_c.output);
    FUNC_DUMMY_Z2_z.licz(SUMA_Z2_z.output);
    
    % sterowanie dla zaworów
    Zz2_val = FUNC_DUMMY_Z2_z.output;
    Zc2_val = FUNC_DUMMY_Z2_c.output;
    
    %% strukturka dla zaworów Zz3 & Zc3
    %
    % regulator PID od temperatury
    PID_Z3_T.calc(T3_PV, T3_SP);
    
    % regulator PID od przep³ywu
    PID_Z3_F.calc(F3_PV, F3_SP);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza zimnego
    SUMA_Z3_z.licz([PID_Z3_T.output, PID_Z3_F.output]);
    
    % weze³ sumacyjny dla zaworu kolektora powietrza ciep³ego
    SUMA_Z3_c.licz([100 - PID_Z3_T.output, PID_Z3_F.output]);
    
    % "pusta" funkcja - na wypadek potrzeb w przysz³oœci
    FUNC_DUMMY_Z3_c.licz(SUMA_Z3_c.output);
    FUNC_DUMMY_Z3_z.licz(SUMA_Z3_z.output);
    
    % sterowanie dla zaworów
    Zz3_val = FUNC_DUMMY_Z3_z.output;
    Zc3_val = FUNC_DUMMY_Z3_c.output;
    
    
    
    %% WPISANIE STEROWAÑ DO AKTUATORÓW
    rury.SetZz1(Zz1_val);
    rury.SetZz2(Zz2_val);
    rury.SetZz3(Zz3_val);
    
    rury.SetZc1(Zc1_val);
    rury.SetZc2(Zc2_val);
    rury.SetZc3(Zc3_val);
    
    rury.SetG(G_val);
    
    rury.SetW(W_val);
end