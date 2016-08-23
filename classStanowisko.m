% changelog
% ----------
%   19.02 - argumenty metod ustawiaj¹cych efektory przyjmuj¹ wartoœci w
%   zakresie 0-100% a nie 0-10000 [mV]


classdef classStanowisko < handle
    % Klasa opisujaca stanowisko laboratoryjne
    %
    % Matlab jest masterem w sieci RS485 Modbus.
    %
    % (c) mjc - Feb 2016 - mciok@mion.elka.pw.edu.pl
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties(GetAccess = 'private', SetAccess = 'private')
        %kontrolery wyjsc analogowych SFAR 8ao
        sfar1 = SFAR(1);
        sfar2 = SFAR(2);
        
        %przetworniki przep³ywu (przep³ywomierze) - P-MAC ModBus
        ft1 = ModBusPmac(11);
        ft2 = ModBusPmac(12);
        ft3 = ModBusPmac(13);
        
        %przetworniki cisnienia - T-MACF ModBus
        tt1 = ModBusTmac(21);
        tt2 = ModBusTmac(22);
        tt3 = ModBusTmac(23);
        ttout = ModBusTmac(20);
        
        %modu³ wejœæ cyfrowych SFAR MiniModbus - stan grza³ki
        mini = miniModbus(3);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties(GetAccess = 'public', SetAccess = 'private')
        serialHandler;
        asm2;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    properties(GetAccess = 'public', SetAccess = 'public')
        %wspó³czynniki na kryzach pomiarowych
        K1 = 1;
        K2 = 1;
        K3 = 1;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    methods ( Access = 'public' )
        %konstruktor
        function obj = classStanowisko(comPort)
            obj.asm2 = NET.addAssembly( [pwd  '\' 'SerialDevicesLib.dll']);
            SerialDevicesLib.ReadAllDevices.initPort(comPort); %baud = 11520 bps, parity = EVEN, stopbits = 1, word = 8
            obj.serialHandler = SerialDevicesLib.ReadAllDevices.port;

            %inicjalizacja sfar'ów
            obj.sfar1.setPort(obj.serialHandler);
            obj.sfar2.setPort(obj.serialHandler);
            %teoretycznie ustawienie typu wyjœæ zosta³o zrobione na
            %poziomie dll'ki ale nie zaszkodzi powtórzyæ...
            obj.sfar1.initOutput(1);
            obj.sfar1.initOutput(2);
            obj.sfar1.initOutput(3);
            obj.sfar1.initOutput(4);
            obj.sfar1.initOutput(5);
            obj.sfar1.initOutput(6);
            obj.sfar1.initOutput(7);
            obj.sfar1.initOutput(8);
            obj.sfar2.initOutput(8);
            %inicjalizacja przetworników przep³ywu
            obj.ft1.setPort(obj.serialHandler);
            obj.ft2.setPort(obj.serialHandler);
            obj.ft3.setPort(obj.serialHandler);
            %inicjalizacja przetworników temperatury
            obj.tt1.setPort(obj.serialHandler);
            obj.tt2.setPort(obj.serialHandler);
            obj.tt3.setPort(obj.serialHandler);
            obj.ttout.setPort(obj.serialHandler);
            %inicjalizacja modu³y wejœc cyfrowych
            obj.mini.setPort(obj.serialHandler);
        end

        %metoda zwracajaca kod wykonania funkcji modbusowej
        function code = error_code(obj, val)
            error_codes = {'FRAME_OK(0)' 'NOT_RECEIVED(1)' 'EXCEPTION(2)' 'NOT_ENOUGHT_DATA(3)' 'FRAMGE_NOT_RECOGNISED(4)' 'CRC_ERROR(5)' 'TERMOSTAT_GRZALKI(6)' };
            if val >= 0 && val <= 6
                code = error_codes(val+1);
            end
            if val < 0 || val > 6
                code = 'UNKNOWN_ERROR_CODE_'+val;
            end
        end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ODCZYT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% UWAGA:
% Poni¿sze metody wysy³aj¹ pojednycz¹ ramkê Modbus
%
% Funkcje posiadaj¹ re-try w przypadku odebrania blednej ramki (3 razy jest
% ponawiana próba)
% 
% Wywolanie:
% klasa.GetFT2(..);
% klasa.GetFT2(..);
% spowoduje wys³anie 2 oddzielnych ramek do sieci RS485
        function [opStatus, inputState] = GetGstatus(obj)
            for i=1:3
                [opStatus, inputState] = obj.mini.getInputStatus(1);
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetFT1(obj)
            for i=1:3
                [opStatus, ret] = obj.ft1.getP1();
                inputState = obj.K1*sqrt(ret);
                if opStatus == 0
                    break
                end
            end
          %[opStatus, inputState] = obj.ft1.getP1();
        end
        
        function [opStatus, inputState] = GetFT2(obj)
            for i=1:3
                [opStatus, ret] = obj.ft2.getP1();
                inputState = obj.K2*sqrt(ret);
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetFT3(obj)
            for i=1:3
                [opStatus, ret] = obj.ft3.getP1();
                inputState = obj.K3*sqrt(ret);
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetTT1(obj)
            for i=1:3
                [opStatus, inputState] = obj.tt1.getT();
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetTT2(obj)
            for i=1:3
                [opStatus, inputState] = obj.tt2.getT();
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetTT3(obj)
            for i=1:3
                [opStatus, inputState] = obj.tt3.getT();
                if opStatus == 0
                    break
                end
            end
        end
        
        function [opStatus, inputState] = GetTTout(obj)
            for i=1:3
                [opStatus, inputState] = obj.ttout.getT();
                if opStatus == 0
                    break
                end
            end
        end
% UWAGA:
% Metoda GetAll(..) równie¿ odpytuje wszystkie slave'y osobnymi ramkami
        function [ output ] = GetAll(obj)
            output_tmp = double(SerialDevicesLib.ReadAllDevices.readAllDevices( ));
            
            output = cell(10,3);
            output{1,1}='punkt';
            output{1,2}='stan';
            output{1,3}='wskazanie';
            output{2,1}='---------';
            output{2,2}='---------';
            output{2,3}='---------';
            output{3,1}='FT1';
            output{4,1}='FT2';
            output{5,1}='FT3';
            output{6,1}='TT1';
            output{7,1}='TT2';
            output{8,1}='TT3';
            output{9,1}='TTout';
            output{10,1}='Grzalka';
            for i=1:8
                output{2+i,2}=output_tmp(i,2);
                output{2+i,3}=output_tmp(i,3);
            end        
        end        
%%%%%%%%%%%%%%%%%%%%%% ZAPIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% UWAGA:
% Poni¿sze metody wysy³aj¹ pojednycz¹ ramkê Modbus
% 
% Wywolanie:
% klasa.SetZz1(..);
% klasa.SetZz2(..);
% spowoduje wys³anie 2 oddzielnych ramek do sieci RS485

        %wysterowanie zaworu rozdzielajacego strumien za nagrzewnic¹
        function opStatus = SetZ(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(7,voltage);
        end
        
        %wysterowanie zaworu 1 kolektora zimnego ( Zz1 )
        function opStatus = SetZz1(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(2,voltage);
        end
        
        %wysterowanie zaworu 2 kolektora zimnego ( Zz2 )
        function opStatus = SetZz2(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(4,voltage);
        end
        
        %wysterowanie zaworu 3 kolektora zimnego ( Zz3 )
        function opStatus = SetZz3(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(6,voltage);
        end
        
        %wysterowanie zaworu 1 kolektora ciep³ego( Zc1 )
        function opStatus = SetZc1(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(1,voltage);
        end
        
        %wysterowanie zaworu 2 kolektora ciep³ego ( Zc2 )
        function opStatus = SetZc2(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(3,voltage);
        end
        
        %wysterowanie zaworu 3 kolektora ciep³ego ( Zc3 )
        function opStatus = SetZc3(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(5,voltage);
        end
        
        %wysterowanie nagrzewnicy ( G )
        function opStatus = SetG(obj, voltage)
            voltage = voltage * 100;
            
            [opStatus, inputState] = obj.GetGstatus(); %stan zabezpieczenia grzalki
            if inputState == 1 && opStatus == 0
                opStatus = obj.sfar2.setVoltage(8,voltage);
            else
                opStatus = 6; %b³ad - zadzia³a³o zabezpieczenie termostatem
            end
        end
        
        %wysterowanie wentylatora ( G )
        function opStatus = SetW(obj, voltage)
            voltage = voltage * 100;
            opStatus = obj.sfar1.setVoltage(8,voltage);
        end
% UWAGA:
% Metoda SetAll(..) wysterowuj wszystkie slave'y jedn¹ ramk¹ modbus
        function SetAll(obj, zc1, zz1, zc2, zz2, zc3, zz3, z, w, g)
            zc1 = zc1 * 100;
            zz1 = zz1 * 100;
            zc2 = zc2 * 100;
            zz2 = zz2 * 100;
            zc3 = zc3 * 100;
            zz3 = zz3 * 100;
            z = z * 100;
            w = w * 100;
            g = g * 100;
            SerialDevicesLib.ReadAllDevices.setOutput(zc1, zz1, zc2, zz2, zc3, zz3, z, w, g);
        end
% Metoda SetAll(..) przeci¹¿ona - bez argumentów - wyœwietla help'a
% function SetAll(obj)
%             disp('function SetAll(Zc1, Zz1, Zc2, Zz2, Zc3, Zz3, Zrozdzielacz, Went., Grzalka)');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % metoda ustawiajaca obiekt w pozycji "spoczynkowej":
        %   zawory na kolektorach otwarte (100%)
        %   zawór rozdzielajacy przy nagrzewnicy 100%
        %   nagrzewnica i wentylator: off (0%)
        function nest(obj)
            obj.SetAll(100, 100, 100, 100, 100, 100, 100, 0, 0);
        end
    end
%%%%%%%%%%% METODY PRYWATNE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    methods ( Access = 'private' )
        %destruktor
        function delete(obj)
            obj.nest(); %powrot do stanu spoczynkowego
            
            pause(2); %!!!
            %zamkniecie portu
            obj.serialHandler.closePort();
            
            pause(2); %!!!
            
            disp('usunieto klase *classStanowisko* - zakonczono wywolanie destruktora');
        end
    end
end

