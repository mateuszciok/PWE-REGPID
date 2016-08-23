classdef SFAR
    
    properties(Constant)
        valueAddress = 51;
        defautValueAddress = 59;
        modeAddress = 67;
        minVolt = 0;
        maxVolt = 10000;
    end
    
    properties
        device;
        address;
    end
    
    methods
        
        function modBusDevice = SFAR(deviceAddress)
            modBusDevice.address = deviceAddress;
            asm2 = NET.addAssembly( [pwd  '\' 'SerialDevicesLib.dll']);
            modBusDevice.device = SerialDevicesLib.ModbusDevice( );
            modBusDevice.device.setAddress(modBusDevice.address);
        end
        
        function setPort(dev, serialHandler)
            dev.device.setTransmissionHandler(serialHandler);
        end
        
        function closePort(dev)
            dev.device.closePort();
        end
        
        % ustawia tryb napi�ciowy dla podanego wyjscia (1-8)
        % param outputNum - numer wyjscia kt�re ma by� ustawione (1-8)
        % return opStatus - status operacji (0 - ok, 1 - brak odpowiedzi, 2
        % - warto�� inna ni� oczekiwana, 3 - bledne dane wejsciowe)
        function opStatus = initOutput(dev, outputNum)
            if(outputNum < 1 || outputNum > 8)
                opStatus = 3;
                return;
            end
            outputMode = 1; % 1 - wyjscie napieciowe
            outputModeAddress = 67 + outputNum;
            opStatus = setParam(dev, outputModeAddress, outputMode);
        end
        
        % wy��cza wyjscie o podanym numerze (1-8)
        function opStatus = closeOutput(dev, outputNum)
            if(outputNum < 1 || outputNum > 8)
                opStatus = 3;
                return;
            end
            outputMode = 0; % 1 - wyjscie napieciowe
            outputModeAddress = 67 + outputNum;
            opStatus = setParam(dev, outputModeAddress, outputMode);
        end
        
        % ustawia warto�� napi�cia dla podanego wyj�cia
        % pram outputNum - numer wyj�cia
        % param V - napi�cie w mV
        function opStatus = setVoltage(dev, outputNum, V)
            if(outputNum < 1 || outputNum > 8)
                opStatus = 3;
                return;
            end
            if(V < dev.minVolt || V > dev.maxVolt)
                opStatus = 3;
                return;
            end
            outPutVolAddress = dev.valueAddress + outputNum;
            opStatus = setParam(dev, outPutVolAddress, V);
        end
        
        % ustawia wartosc pod podanym rejestrem
        % param regNum - numer rejestru w modBusie do modyfikacji
        % param value - warto�� jaka ma by� przypisana
        % return opStatus - status operacji (0 - ok, 1 - brak odpowiedzi, 
        % 2 - warto�� po modyfikacji inna ni� oczekiwana)
        function opStatus = setParam(dev, regNum, value)
            dev.device.set16bitRegister(regNum, value);
            opStatus = dev.device.lastFrameStatus();
        end
        
    end
    
end

