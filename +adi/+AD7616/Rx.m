classdef Rx < adi.common.Rx & matlabshared.libiio.base & adi.common.Attribute
    % AD7616 Precision ADC Class
    % adi.AD7616.Rx Receives data from the AD7616 ADC
    %   The adi.AD7616.Rx System object is a signal source that can receive
    %   data from the AD7616.
    %
    %   rx = adi.AD7616.Rx;
    %   rx = adi.AD7616.Rx('uri','192.168.2.1');
    %
    %   <a href="https://www.analog.com/media/en/technical-documentation/data-sheets/AD7616.pdf">AD7616 Datasheet</a>

    properties (Nontunable)
        % SamplesPerFrame Samples Per Frame
        %   Number of samples per frame, specified as an even positive
        %   integer.
        SamplesPerFrame = 4096

        % SampleRate Sample Rate
        %   Baseband sampling rate in Hz, specified as a scalar
        %   in samples per second.
        SampleRate = '1000000'
    end

    properties (Dependent)
        % Voltage
        %   ADC Voltage in mV
        Voltage

        % VoltageScale Voltage Scale
        %   ADC Voltage scale.
        VoltageScale

        % VoltageOffset Voltage Offset
        %   ADC Voltage offset.
        VoltageOffset
    end

    % Channel names
    properties (Nontunable, Hidden, Constant)
        channel_names = {'voltage0', 'voltage1', 'voltage2', 'voltage3', ...
                         'voltage4', 'voltage5', 'voltage6', 'voltage7', ...
                         'voltage8', 'voltage9', 'voltage10', 'voltage11', ... 
                         'voltage12', 'voltage13', 'voltage14', 'voltage15'}
    end

    % isOutput
    properties (Hidden, Nontunable, Access = protected)
        isOutput = false
    end

    properties (Nontunable, Hidden)
        Timeout = Inf
        kernelBuffersCount = 1
        dataTypeStr = 'int32'
        phyDevName = 'ad7616'
        devName = 'ad7616'
    end

    properties (Nontunable, Hidden, Constant)
        Type = 'Rx'
    end

    properties (Hidden, Constant)
        ComplexData = false
    end

    methods
        %% Constructor
        function obj = Rx(varargin)
            obj = obj@matlabshared.libiio.base(varargin{:});
            obj.enableExplicitPolling = false;
            obj.EnabledChannels = 1;
            obj.BufferTypeConversionEnable = true;
            obj.uri = 'ip:analog.local';
        end

        function flush(obj)
            % Flush the buffer
            flushBuffers(obj);
        end

        function set.SampleRate(obj, value)
            % Set device sampling rate
            obj.SampleRate = value;
            if obj.ConnectedToDevice
                obj.setDeviceAttributeRAW('sampling_frequency', value);
            end
        end
    end

    %% API Functions
    methods (Hidden, Access = protected)
        function setupInit(obj)
            % Write all attributes to device once connected through set
            % methods
            % Do writes directly to hardware without using set methods.
            % This is required since Simulink support doesn't support
            % modification to nontunable variables at SetupImpl
            obj.setDeviceAttributeRAW('sampling_frequency',num2str(obj.SampleRate));
        end
    end
end
