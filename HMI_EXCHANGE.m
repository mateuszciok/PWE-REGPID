%% Silnik wymiany informacji pomiedzy HMI a skryptami
%
% mjc 2016
%%
if HMI_PID_wentylator.reTune == 1 
    PID_wentylator.reTune(HMI_PID_wentylator.K, HMI_PID_wentylator.Ti, HMI_PID_wentylator.Td, HMI_PID_wentylator.Tpr);
    
    HMI_PID_wentylator.reTune = 0;
end

if HMI_PID_grzalka.reTune == 1 
    PID_grzalka.reTune(HMI_PID_grzalka.K, HMI_PID_grzalka.Ti, HMI_PID_grzalka.Td, HMI_PID_grzalka.Tpr);
    
    HMI_PID_grzalka.reTune = 0;
end

if HMI_PID_Z1_T.reTune == 1 
    PID_Z1_T.reTune(HMI_PID_Z1_T.K, HMI_PID_Z1_T.Ti, HMI_PID_Z1_T.Td, HMI_PID_Z1_T.Tpr);
    
    HMI_PID_Z1_T.reTune = 0;
end
if HMI_PID_Z1_F.reTune == 1 
    PID_Z1_F.reTune(HMI_PID_Z1_F.K, HMI_PID_Z1_F.Ti, HMI_PID_Z1_F.Td, HMI_PID_Z1_F.Tpr);
    
    HMI_PID_Z1_F.reTune = 0;
end

if HMI_PID_Z2_T.reTune == 1 
    PID_Z2_T.reTune(HMI_PID_Z2_T.K, HMI_PID_Z2_T.Ti, HMI_PID_Z2_T.Td, HMI_PID_Z2_T.Tpr);
    
    HMI_PID_Z2_T.reTune = 0;
end
if HMI_PID_Z2_F.reTune == 1 
    PID_Z2_F.reTune(HMI_PID_Z2_F.K, HMI_PID_Z2_F.Ti, HMI_PID_Z2_F.Td, HMI_PID_Z2_F.Tpr);
    
    HMI_PID_Z2_F.reTune = 0;
end

if HMI_PID_Z3_T.reTune == 1 
    PID_Z3_T.reTune(HMI_PID_Z3_T.K, HMI_PID_Z3_T.Ti, HMI_PID_Z3_T.Td, HMI_PID_Z3_T.Tpr);
    
    HMI_PID_Z3_T.reTune = 0;
end
if HMI_PID_Z3_F.reTune == 1 
    PID_Z3_F.reTune(HMI_PID_Z3_F.K, HMI_PID_Z3_F.Ti, HMI_PID_Z3_F.Td, HMI_PID_Z3_F.Tpr);
    
    HMI_PID_Z3_F.reTune = 0;
end