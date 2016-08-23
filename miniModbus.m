classdef miniModbus
    %MINIMODBUS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant)
        firstInputAddress = 800;
        inputCount = 4;
    end
    
    properties
        device;
        address;
    end
    
    methods
        function modBusDevice = miniModbus(deviceAddress)
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
        
        function [opStatus, inputStatus] = getInputStatus(dev, inputNum)
            if(inputNum < 1 || inputNum > dev.inputCount)
                opStatus = 7;
                inputStatus = NaN;
                return;
            end
            vals = dev.device.request(dev.firstInputAddress + inputNum - 1, 1, 4, 2);
            opStatus = dev.device.lastFrameStatus();
            if(isempty(vals) || ~isfinite(vals(1)))
                inputStatus = NaN;
                return;
            end
            inputStatus = double(vals(1));
        end
    end
    
end

