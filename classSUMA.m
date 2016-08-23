classdef classSUMA < handle
    % classSUMA - prosta klasa wêz³a sumacyjnego o konfigurowalnej iloœci
    % wejœæ
    %
    % mjc - 2016
    % #####################################################################
    % atrybuty publiczne (zewnetrzne)
    properties(GetAccess = 'public', SetAccess = 'private')
        ilosc_wejsc = 0;
        output = 0;
        
        % limity
        H_lim = 0;
        L_lim = 0;
    end
    
    % #####################################################################
    % metody publiczne
    methods(Access = 'public')
        % konstruktor
        function obj = classSUMA(ilosc_wejsc, High_lim, Low_lim)
            if ilosc_wejsc < 2
                error('wêze³ sumacyjny musi mieæ min. 2 wejœcia');
            end
            
            obj.ilosc_wejsc = ilosc_wejsc;
            
            % limity
            obj.H_lim = High_lim;
            obj.L_lim = Low_lim;
        end
        % #################################################################
        function value = licz(obj, wejscia)
            [x, y] = size(wejscia);
            
            if (x ~= 1) || (y ~= obj.ilosc_wejsc)
                error('Nieprawid³owy rozmiar wektora wejœciowego do wêz³a sumacyjnego');
            else
                val = 0;
                for i = 1:obj.ilosc_wejsc
                    val = val + wejscia(i);
                end
                
                % limity
                if val > obj.H_lim
                    val = obj.H_lim;
                end
                if val < obj.L_lim
                    val = obj.L_lim;
                end
                
                % przepisanie na wyjscie
                obj.output = val;
                value = val;
            end
        end
    end
end

