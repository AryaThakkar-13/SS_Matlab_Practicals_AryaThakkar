function Even_Odd_Decomposition_Visualizer

clc;
close all;

% Main GUI window
fig = figure('Name','Even-Odd Decomposition Visualizer', ...
    'NumberTitle','off', ...
    'Position',[80 50 1250 850], ...
    'Color','white', ...
    'MenuBar','none');

% Heading
uicontrol(fig,'Style','text', ...
    'String','EVEN-ODD DECOMPOSITION VISUALIZER', ...
    'Units','normalized', ...
    'Position',[0.15 0.94 0.70 0.045], ...
    'FontSize',17,'FontWeight','bold', ...
    'BackgroundColor','white');

% Preset signal selection
uicontrol(fig,'Style','text', ...
    'String','Select Signal:', ...
    'Units','normalized', ...
    'Position',[0.02 0.875 0.10 0.04], ...
    'BackgroundColor','white','FontSize',10);

uicontrol(fig,'Style','popupmenu', ...
    'String',{'Custom Signal', ...
    'sin(2*pi*t) + 0.5*cos(pi*t)', ...
    'exp(-abs(t))', ...
    'u(t)', ...
    'exp(-t + 1i*2*pi*t).*u(t)'}, ...
    'Units','normalized', ...
    'Position',[0.12 0.875 0.43 0.045], ...
    'FontSize',10, ...
    'Callback',@selectSignal);

% Signal expression input
uicontrol(fig,'Style','text', ...
    'String','Enter x(t):', ...
    'Units','normalized', ...
    'Position',[0.02 0.815 0.10 0.04], ...
    'BackgroundColor','white','FontSize',10);

exprEdit = uicontrol(fig,'Style','edit', ...
    'String','sin(2*pi*t) + 0.5*cos(pi*t)', ...
    'Units','normalized', ...
    'Position',[0.12 0.815 0.58 0.05], ...
    'BackgroundColor','white','FontSize',10, ...
    'HorizontalAlignment','left');

% Time range input
uicontrol(fig,'Style','text', ...
    'String','T:', ...
    'Units','normalized', ...
    'Position',[0.72 0.875 0.04 0.04], ...
    'BackgroundColor','white','FontSize',10);

rangeEdit = uicontrol(fig,'Style','edit', ...
    'String','5', ...
    'Units','normalized', ...
    'Position',[0.76 0.875 0.07 0.045], ...
    'BackgroundColor','white','FontSize',10);

% Run button
uicontrol(fig,'Style','pushbutton', ...
    'String','Run Decomposition', ...
    'Units','normalized', ...
    'Position',[0.85 0.865 0.13 0.06], ...
    'FontSize',10,'FontWeight','bold', ...
    'Callback',@runDecomposition);

% Viva button
uicontrol(fig,'Style','pushbutton', ...
    'String','Viva: Unit Step', ...
    'Units','normalized', ...
    'Position',[0.85 0.795 0.13 0.05], ...
    'FontSize',10, ...
    'Callback',@showViva);

% Instructions
uicontrol(fig,'Style','text', ...
    'String',['Use t in your expression. Available functions: ', ...
    'u(t), rectp(t), sin, cos, exp and abs.'], ...
    'Units','normalized', ...
    'Position',[0.12 0.755 0.70 0.035], ...
    'BackgroundColor','white','FontSize',9, ...
    'HorizontalAlignment','left');

% Status and numerical results
statusText = uicontrol(fig,'Style','text', ...
    'String','Enter a signal and click Run Decomposition.', ...
    'Units','normalized', ...
    'Position',[0.02 0.705 0.96 0.04], ...
    'BackgroundColor','white','FontSize',9, ...
    'HorizontalAlignment','left');

% Four plotting areas 
% Top row
ax(1) = axes('Parent',fig, ...
    'Position',[0.07 0.44 0.39 0.22]);

ax(2) = axes('Parent',fig, ...
    'Position',[0.56 0.44 0.37 0.22]);

% Bottom row
ax(3) = axes('Parent',fig, ...
    'Position',[0.07 0.07 0.39 0.22]);

ax(4) = axes('Parent',fig, ...
    'Position',[0.56 0.07 0.37 0.22]);

% Calculate and display the decomposition
runDecomposition();
    % Select a preset signal
    function selectSignal(src,~)
        choices = get(src,'String');
        selected = get(src,'Value');
        if selected == 1
            return;
        end
        set(exprEdit,'String',choices{selected});
    end

    % Main decomposition function
    function runDecomposition(~,~)
        % Read the time range
        T = str2double(get(rangeEdit,'String'));
        if isempty(T) || ~isreal(T) || ...
                ~isfinite(T) || T <= 0
            errordlg('Enter a positive finite value for T.', ...
                'Invalid Time Range');
            return;
        end

        % Create a symmetric time axis
        t = linspace(-T,T,2001);

        % Define the unit step function
        u = @(z) double(z > 0) + 0.5*double(z == 0); %#ok<NASGU>

        % Define a rectangular pulse of width 1
        rectp = @(z) double(abs(z) < 0.5) + ...
            0.5*double(abs(z) == 0.5); %#ok<NASGU>

        % Read the entered expression
        expr = strtrim(get(exprEdit,'String'));

        if isempty(expr)
            errordlg('Please enter a signal expression.', ...
                'Missing Signal');
            return;
        end

        % Calculate the signal
        try
            x = eval(expr);
            % Check the signal
            if ~isnumeric(x) || ~isvector(x) || ...
                    numel(x) ~= numel(t)
                errordlg(['The expression must produce one ', ...
                    'value for every time sample. Use .* , ./ ', ...
                    'and .^ where needed.'], ...
                    'Invalid Signal');
                return;
            end

            % Convert the signal into a row vector
            x = reshape(x,1,[]);

            if any(~isfinite(real(x))) || ...
                    any(~isfinite(imag(x)))
                errordlg('The signal contains NaN or Inf values.', ...
                    'Invalid Signal');
                return;
            end

        catch
            errordlg(['Invalid expression. Check the formula ', ...
                'and use t as the time variable.'], ...
                'Signal Error');
            return;
        end

        % Calculate x(-t)
        % The time axis is symmetric and equally spaced.
        x_reverse = fliplr(x);

        % Even and odd components
        x_even = (x + x_reverse)/2;
        x_odd  = (x - x_reverse)/2;

        % Reconstructed signal
        x_reconstructed = x_even + x_odd;

        % Reconstruction error
        reconstructionError = max(abs(x - x_reconstructed));

        % Energy calculation
        % Absolute square also works for complex signals.
        Ex = trapz(t,abs(x).^2);
        Ee = trapz(t,abs(x_even).^2);
        Eo = trapz(t,abs(x_odd).^2);

        energyError = abs(Ex - (Ee + Eo));

        % Relative energy error
        relativeEnergyError = energyError/max(Ex,eps);

        % Clear previous graphs
        for k = 1:4
            cla(ax(k));
            grid(ax(k),'on');
            box(ax(k),'on');
            set(ax(k),'FontSize',9);
        end

        % Real-valued signal
        if isreal(x)

            plot(ax(1),t,x,'b','LineWidth',1.5);
            title(ax(1),'Original Signal x(t)');
            xlabel(ax(1),'Time t');
            ylabel(ax(1),'Amplitude');

            plot(ax(2),t,x_even,'r','LineWidth',1.5);
            title(ax(2),'Even Component x_e(t)');
            xlabel(ax(2),'Time t');
            ylabel(ax(2),'Amplitude');

            plot(ax(3),t,x_odd,'m','LineWidth',1.5);
            title(ax(3),'Odd Component x_o(t)');
            xlabel(ax(3),'Time t');
            ylabel(ax(3),'Amplitude');

            plot(ax(4),t,x_reconstructed,'g','LineWidth',1.5);
            title(ax(4),'Reconstructed Signal x_e(t)+x_o(t)');
            xlabel(ax(4),'Time t');
            ylabel(ax(4),'Amplitude');

        % Complex-valued signal
        else

            % Real part of the even component
            plot(ax(1),t,real(x_even),'b','LineWidth',1.5);
            title(ax(1),'Real Part of Even Component');
            xlabel(ax(1),'Time t');
            ylabel(ax(1),'Real Amplitude');

            % Real part of the odd component
            plot(ax(2),t,real(x_odd),'r','LineWidth',1.5);
            title(ax(2),'Real Part of Odd Component');
            xlabel(ax(2),'Time t');
            ylabel(ax(2),'Real Amplitude');

            % Imaginary part of the even component
            plot(ax(3),t,imag(x_even),'m','LineWidth',1.5);
            title(ax(3),'Imaginary Part of Even Component');
            xlabel(ax(3),'Time t');
            ylabel(ax(3),'Imaginary Amplitude');

            % Imaginary part of the odd component
            plot(ax(4),t,imag(x_odd),'g','LineWidth',1.5);
            title(ax(4),'Imaginary Part of Odd Component');
            xlabel(ax(4),'Time t');
            ylabel(ax(4),'Imaginary Amplitude');

        end

        % Display verification results
        result = sprintf([ ...
            'Reconstruction error = %.3g   |   ', ...
            'E_x = %.6g   |   E_even + E_odd = %.6g   |   ', ...
            'Relative energy error = %.3g'], ...
            reconstructionError,Ex,Ee+Eo,relativeEnergyError);

        set(statusText,'String',result);

        drawnow;

    end

    % Viva demonstration: even part of unit step
    function showViva(~,~)

        % Symmetric time axis
        tv = linspace(-3,3,1201);

        % Unit step with u(0) = 0.5
        uv = double(tv > 0) + 0.5*double(tv == 0);

        % Unit step evaluated at -t
        u_reverse = double(-tv > 0) + ...
            0.5*double(-tv == 0);

        % Even component of unit step
        u_even = (uv + u_reverse)/2;

        % Rectangular pulse of width 1
        rect = double(abs(tv) < 0.5) + ...
            0.5*double(abs(tv) == 0.5);

        % Open a separate viva window
        vf = figure('Name','Viva: Unit Step and Rectangular Pulse', ...
            'NumberTitle','off', ...
            'Position',[180 150 1000 550], ...
            'Color','white');

        av1 = subplot(2,1,1,'Parent',vf);

        plot(av1,tv,uv,'b','LineWidth',1.5);
        hold(av1,'on');
        plot(av1,tv,rect,'r--','LineWidth',1.5);
        hold(av1,'off');
        grid(av1,'on');
        title(av1,'Unit Step u(t) and Rectangular Pulse');
        xlabel(av1,'Time t');
        ylabel(av1,'Amplitude');
        legend(av1,{'u(t)','Rectangular Pulse'}, ...
            'Location','best');

        av2 = subplot(2,1,2,'Parent',vf);

        plot(av2,tv,u_even,'b','LineWidth',1.8);
        hold(av2,'on');
        plot(av2,tv,rect,'r--','LineWidth',1.5);
        hold(av2,'off');
        grid(av2,'on');
        title(av2,'Even Part of u(t) Compared with Rectangular Pulse');
        xlabel(av2,'Time t');
        ylabel(av2,'Amplitude');
        legend(av2,{'Even Part of u(t)','Rectangular Pulse'}, ...
            'Location','best');
        ylim(av2,[-0.2 1.2]);

        msg = sprintf([ ...
            'Even part of u(t) = [u(t)+u(-t)]/2 = 0.5.\n\n', ...
            'It is NOT the same as a rectangular pulse.\n', ...
            'The even part remains 0.5, while the rectangular ', ...
            'pulse is nonzero only over a limited time interval.']);

        msgbox(msg,'Viva Explanation','help');

    end
end