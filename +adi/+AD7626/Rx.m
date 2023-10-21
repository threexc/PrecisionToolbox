classdef Rx < adi.AD762x.Base & matlabshared.libiio.base & adi.common.Attribute
    % AD7626 Precision ADC Class
    % 
    % adi.AD7626.Rx Receives data from the AD7626 ADC
    % The adi.AD7626.Rx System object is a signal source that can receive
    % data from the AD7626.
    %
    %   `rx = adi.AD7626.Rx;`
    %   `rx = adi.AD7626.Rx('uri','192.168.2.1');`
    %
    % `AD7626 Datasheet <https://www.analog.com/media/en/technical-documentation/data-sheets/AD7626.pdf>`_

    methods
        %% Constructor
        function obj = Rx(varargin)
            obj = obj@adi.AD762x.Base('ad7626', 'ad7626', 'int16', varargin{:});
            obj.enableExplicitPolling = false;
            obj.EnabledChannels = 1;
            obj.BufferTypeConversionEnable = true;
        end
    end
end