classdef classPID < handle
    % classPID - klasa prostego regulatora PID
    %
    % mjc - 2016
    % #####################################################################
    % atrybuty prywante (wewn�trzne)
    properties(GetAccess = 'public', SetAccess = 'private')
        % sta�e PIDa
        K = 0;          % wzmocnienie
        Ti = 0;         % sta�a ca�kowania - czas zdwojenia
        Td = 0;         % sta�a cz�onu r�niczkuj�cego - czas wyprzedzenia
        Tpr = 1;        % czas pr�bkowania
    end
    properties(GetAccess = 'private', SetAccess = 'private')
        % uchyb
        e = zeros(1,3); % e(1) - uchyb aktualny (w chwili "k"), e(2) - uchyb w chwili "k-1", e(3) - uchyb w chwili "k-2"
        % wejscie w chwili k-1
        output_old = 0; 
        
        % zmienne pomocnicze trzymaj�ce warto�ci PIDa
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
        H_lim = 0;      % g�rny zakres warto�ci
        L_lim = 0;      % dolny zakres warto�ci
        
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
            % przepisanie argument�w wywo�ania na atrybuty obiektu
            obj.K = K;
            obj.Ti = Ti;
            obj.Td = Td;
            obj.Tpr = Tpr;
            obj.H_lim = H_lim;
            obj.L_lim = L_lim;
            obj.Dir = Dir;
            
            % przeliczenie sta�ych PIDa dyskretnego
            obj.pidr0 = K*(1 + (obj.Tpr/(2*Ti)) + (Td/obj.Tpr));
            obj.pidr1 = K*((obj.Tpr/(2*Ti)) - (2*Td/obj.Tpr) - 1);
            obj.pidr2 = K*(Td/obj.Tpr);
        end
        % #################################################################
        % przeliczenie PIDa - metoda "sztucznie" (po matlabowsku)
        % przeci��ona:
        %
        % mo�n� j� wywo�a� w postaci:
        % 1) obj.calc(INPUT_VAL) - jeden argument w postaci wartosci
        % wej�ciowej - kalkulacja zostanie wykonana na podstawie
        % "zapami�tanego" wcze�niej SetPointa
        %
        % 2) obj.calc(INPUT_VAL, SET_POINT) - pierwszy argument j.w., drugi
        % argument to warto�� SetPoint
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
                   error('b��d wywo�ania - nale�y poda� albo 1 albo 2 argumenty liczbowe, odpowiednio: warto�� wej�cia oraz ew. warto�� zadan�');
           end

           % przesuni�cie uchyb�w w tablicy
           obj.e(3) = obj.e(2);
           obj.e(2) = obj.e(1);
           
           % nowy uchyb
           if obj.Dir % direct
               obj.e(1) = obj.SP - INPUT_VAL;
           else % indirect
               obj.e(1) = INPUT_VAL - obj.SP;
           end
           
           % sygna� steruj�cy z poprzedniej chwili czasowej
           obj.output_old = obj.output;
           
           % wyj�cie PIDa
           obj.output = obj.pidr0*obj.e(1) + obj.pidr1*obj.e(2) + obj.pidr2*obj.e(3) + obj.output_old;
           
           % ograniczenia
           if obj.output > obj.H_lim
               obj.output = obj.H_lim;
           end
           if obj.output < obj.L_lim
               obj.output = obj.L_lim;
           end
           
           % aktualna warto�� zwracana jako return metody
           pid_out = obj.output;
        end
        % #################################################################
        % przestrojenie PIDa
        function  reTune(obj, K, Ti, Td, Tpr)
            % przepisanie argument�w wywo�ania na atrybuty obiektu
            obj.K = K;
            obj.Ti = Ti;
            obj.Td = Td;
            obj.Tpr = Tpr;
            
            % przeliczenie sta�ych PIDa dyskretnego
            obj.pidr0 = K*(1 + (obj.Tpr/(2*Ti)) + (Td/obj.Tpr));
            obj.pidr1 = K*((obj.Tpr/(2*Ti)) - (2*Td/obj.Tpr) - 1);
            obj.pidr2 = K*(Td/obj.Tpr);
        end
    end
    
end

