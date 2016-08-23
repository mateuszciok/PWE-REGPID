classdef classPID < handle
    % classPID - klasa prostego regulatora PID
    %
    % mjc - 2016
    % #####################################################################
    % atrybuty prywante (wewnêtrzne)
    properties(GetAccess = 'public', SetAccess = 'private')
        % sta³e PIDa
        K = 0;          % wzmocnienie
        Ti = 0;         % sta³a ca³kowania - czas zdwojenia
        Td = 0;         % sta³a cz³onu ró¿niczkuj¹cego - czas wyprzedzenia
        Tpr = 1;        % czas próbkowania
    end
    properties(GetAccess = 'private', SetAccess = 'private')
        % uchyb
        e = zeros(1,3); % e(1) - uchyb aktualny (w chwili "k"), e(2) - uchyb w chwili "k-1", e(3) - uchyb w chwili "k-2"
        % wejscie w chwili k-1
        output_old = 0; 
        
        % zmienne pomocnicze trzymaj¹ce wartoœci PIDa
        pidr0 = 0;
        pidr1 = 0;
        pidr2 = 0;
    end
    % #####################################################################
    % atrybuty publiczne (zewnetrzne)
    properties(GetAccess = 'public', SetAccess = 'public')
        % wejscie pomiarowe
        input = 0;
        % SetPoint
        SP = 0;
           
        % limity
        H_lim = 0;      % górny zakres wartoœci
        L_lim = 0;      % dolny zakres wartoœci
        
        % 1 - direct PID, 0 - indirect PID
        Dir = 0;
        
        % wyjscie PIDa
        output = 0;
    end
    
    % #####################################################################
    % metody publiczne
    methods(Access = 'public')
        % konstruktor
        function obj = classPID(K, Ti, Td, Tpr, H_lim, L_lim, Dir) 
            % przepisanie argumentów wywo³ania na atrybuty obiektu
            obj.K = K;
            obj.Ti = Ti;
            obj.Td = Td;
            obj.Tpr = Tpr;
            obj.H_lim = H_lim;
            obj.L_lim = L_lim;
            obj.Dir = Dir;
            
            % przeliczenie sta³ych PIDa dyskretnego
            obj.pidr0 = K*(1 + (obj.Tpr/(2*Ti)) + (Td/obj.Tpr));
            obj.pidr1 = K*((obj.Tpr/(2*Ti)) - (2*Td/obj.Tpr) - 1);
            obj.pidr2 = K*(Td/obj.Tpr);
        end
        % #################################################################
        % przeliczenie PIDa - metoda "sztucznie" (po matlabowsku)
        % przeci¹¿ona:
        %
        % mo¿n¹ j¹ wywo³aæ w postaci:
        % 1) obj.calc(INPUT_VAL) - jeden argument w postaci wartosci
        % wejœciowej - kalkulacja zostanie wykonana na podstawie
        % "zapamiêtanego" wczeœniej SetPointa
        %
        % 2) obj.calc(INPUT_VAL, SET_POINT) - pierwszy argument j.w., drugi
        % argument to wartoœæ SetPoint
        function pid_out = calc(obj, varargin)
           switch nargin
               case 2
                   % jeden argument
                   INPUT_VAL = varargin{1};
               case 3
                   % dwa argumenty
                   INPUT_VAL = varargin{1};
                   obj.SP = varargin{2};
               otherwise
                   error('b³¹d wywo³ania - nale¿y podaæ albo 1 albo 2 argumenty liczbowe, odpowiednio: wartoœæ wejœcia oraz ew. wartoœæ zadan¹');
           end

           % przesuniêcie uchybów w tablicy
           obj.e(3) = obj.e(2);
           obj.e(2) = obj.e(1);
           
           % nowy uchyb
           if obj.Dir % direct
               obj.e(1) = obj.SP - INPUT_VAL;
           else % indirect
               obj.e(1) = INPUT_VAL - obj.SP;
           end
           
           % sygna³ steruj¹cy z poprzedniej chwili czasowej
           obj.output_old = obj.output;
           
           % wyjœcie PIDa
           obj.output = obj.pidr0*obj.e(1) + obj.pidr1*obj.e(2) + obj.pidr2*obj.e(3) + obj.output_old;
           
           % ograniczenia
           if obj.output > obj.H_lim
               obj.output = obj.H_lim;
           end
           if obj.output < obj.L_lim
               obj.output = obj.L_lim;
           end
           
           % aktualna wartoœæ zwracana jako return metody
           pid_out = obj.output;
        end
        % #################################################################
        % przestrojenie PIDa
        function  reTune(obj, K, Ti, Td, Tpr)
            % przepisanie argumentów wywo³ania na atrybuty obiektu
            obj.K = K;
            obj.Ti = Ti;
            obj.Td = Td;
            obj.Tpr = Tpr;
            
            % przeliczenie sta³ych PIDa dyskretnego
            obj.pidr0 = K*(1 + (obj.Tpr/(2*Ti)) + (Td/obj.Tpr));
            obj.pidr1 = K*((obj.Tpr/(2*Ti)) - (2*Td/obj.Tpr) - 1);
            obj.pidr2 = K*(Td/obj.Tpr);
        end
    end
    
end

