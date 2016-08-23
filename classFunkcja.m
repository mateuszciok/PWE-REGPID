classdef classFunkcja < handle
    % classFUNKCJA - klasa funkcji "sprz�gaj�cej" aktuatory z czujnikami
    % (?!)
    %
    % mjc - 2016
    % #####################################################################
    % atrybuty publiczne (zewnetrzne)
    properties(GetAccess = 'public', SetAccess = 'private')
        % ilo�� zdefiniowanych punkt�w
        Nb = 0;
        
        % wyj�cie
        output = 0;
        
        % wektor X
        vectX = [0];
        
        % wektor Y
        vectY = [0];
        
        % limity
        H_lim = 0;
        L_lim = 0;
    end
    % #####################################################################
    methods(Access = 'public')
        % konstruktor
        function obj = classFunkcja(wektorX, wektorY, High_lim, Low_lim)
          [aX, bX] = size(wektorX);
          [aY, bY] = size(wektorY);
          
          if (aX == 1) && (aY == 1) && (bX == bY) && (bX >= 2)
              obj.Nb = bX; % d�ugo�� wektor�w
              obj.vectX = wektorX;
              obj.vectY = wektorY;
              
              obj.H_lim = High_lim;
              obj.L_lim = Low_lim;
          else
              error('B��d danych wejsciowych: wektor X oraz Y maj� by� wektorami poziomymi o jednakowej d�ugo�ci');
          end
        end
        % #################################################################
        % wyliczenie Y dla zadanego X
        function val = licz(obj, X)
            % wyznaczenie przedzialika
            for i=1:obj.Nb-1
               if (obj.vectX(i) <= X) && (obj.vectX(i+1) >= X)
                   break;
               end
            end
            if i < obj.Nb
                % sta�e do wyznaczenie r�wnania prostej przechodzacej przez dwa
                % punkty
                x1 = obj.vectX(i);
                y1 = obj.vectY(i);
     
                x2 = obj.vectX(i+1);
                y2 = obj.vectY(i+1);
                
                % sytuacja gdy punkt le�y "za" zdefiniowan� struktur�
                % punkt�w
                if X > obj.vectX(obj.Nb)
                    x1 = obj.vectX(obj.Nb - 1);
                    y1 = obj.vectY(obj.Nb - 1);
     
                    x2 = obj.vectX(obj.Nb);
                    y2 = obj.vectY(obj.Nb);
                end
                % sytuacja gdy punkt le�y "przed" zdefiniowan� struktur�
                % punkt�w
                if X < obj.vectX(1)
                    x1 = obj.vectX(1);
                    y1 = obj.vectY(1);
     
                    x2 = obj.vectX(2);
                    y2 = obj.vectY(2);
                end
                
                % r�wnanie prostej
                y = ( (y2 - y1)*(X - x1) ) / (x2 - x1) + y1;
                
                % limity
                if y > obj.H_lim
                    y = obj.H_lim;
                end
                if y < obj.L_lim
                    y = obj.L_lim;
                end
                
                obj.output = y;
                val = y;
            end   
        end
    end
    
end

