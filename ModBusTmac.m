classdef ModBusTmac
    
    properties(Constant)
        T_DP_ID = 5000;
    end
    
    properties
        address;
        device;
    end
    
    methods
        
        % konstruktor
        % param name - nazwa uzywana do identyfikacji ustawien urzadzenia 
        % (zapis/odczyt) konfiguracji portu dla danego urz¹dzenia
        function tmacDevice = ModBusTmac(deviceAddress)
            tmacDevice.address = deviceAddress;
            asm2 = NET.addAssembly( [pwd  '\' 'SerialDevicesLib.dll']);
            tmacDevice.device = SerialDevicesLib.ModbusDevice( );
            tmacDevice.device.setAddress(tmacDevice.address);
        end
        
        function setPort(dev, serialHandler)
            dev.device.setTransmissionHandler(serialHandler);
        end
        
        function closePort(dev)
            dev.device.closePort();
        end
       
        % odczytuje dan¹ bie¿¹c¹ p1 (ró¿nica ciœnieñ)
        % return opStatus - status operacji (0 - ok)
        % return P1 - wartoœæ ró¿nicy ciœnieñ (jeœli opStatus = 0) lub NaN
        function [opStatus, T1] = getT(dev)
            %typ odczytywanej wartoœci:
            % 0 - word
            % 1 - float z wag¹ bitów (1 0 3 2) (chyba)
            % 2 - float z wag¹ bitów (3 2 1 0) 
            % 3 - 2 word tworz¹ce razem wartoœc typu 2
            vals = dev.device.request(dev.T_DP_ID, 1, 3);
            opStatus = dev.device.lastFrameStatus();
            if(isempty(vals) || ~isfinite(vals(1)))
                T1 = NaN;
                return;
            end
            T1 = double(vals(1));
        end
        
    end
    
end

