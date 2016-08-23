function varargout = HMI(varargin)
% HMI MATLAB code for HMI.fig
%      HMI, by itself, creates a new HMI or raises the existing
%      singleton*.
%
%      H = HMI returns the handle to a new HMI or the handle to
%      the existing singleton*.
%
%      HMI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HMI.M with the given input arguments.
%
%      HMI('Property','Value',...) creates a new HMI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HMI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HMI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HMI

% Last Modified by GUIDE v2.5 16-Aug-2016 23:45:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HMI_OpeningFcn, ...
                   'gui_OutputFcn',  @HMI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before HMI is made visible.
function HMI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HMI (see VARARGIN)

% Choose default command line output for HMI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HMI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% zaczytanie aktualnych nastaw PIDow
% - grzalka
Heater_K = evalin('base','PID_grzalka.K');
set(handles.Heater_K,'String',num2str(Heater_K));
Heater_Ti = evalin('base','PID_grzalka.Ti');
set(handles.Heater_Ti,'String',num2str(Heater_Ti));
Heater_Td = evalin('base','PID_grzalka.Td');
set(handles.Heater_Td,'String',num2str(Heater_Td));
Heater_Tpr = evalin('base','PID_grzalka.Tpr');
set(handles.Heater_Tpr,'String',num2str(Heater_Tpr));

% - wentylator
Fan_K = evalin('base','PID_wentylator.K');
set(handles.Fan_K,'String',num2str(Fan_K));
Fan_Ti = evalin('base','PID_wentylator.Ti');
set(handles.Fan_Ti,'String',num2str(Fan_Ti));
Fan_Td = evalin('base','PID_wentylator.Td');
set(handles.Fan_Td,'String',num2str(Fan_Td));
Fan_Tpr = evalin('base','PID_wentylator.Tpr');
set(handles.Fan_Tpr,'String',num2str(Fan_Tpr));

% - zawory kondygnacji 1 - petla sp. z T
Z1_T_K = evalin('base','PID_Z1_T.K');
set(handles.Z1_T_K,'String',num2str(Z1_T_K));
Z1_T_Ti = evalin('base','PID_Z1_T.Ti');
set(handles.Z1_T_Ti,'String',num2str(Z1_T_Ti));
Z1_T_Td = evalin('base','PID_Z1_T.Td');
set(handles.Z1_T_Td,'String',num2str(Z1_T_Td));
Z1_T_Tpr = evalin('base','PID_Z1_T.Tpr');
set(handles.Z1_T_Tpr,'String',num2str(Z1_T_Tpr));
% - zawory kondygnacji 1 - petla sp. z F
Z1_F_K = evalin('base','PID_Z1_F.K');
set(handles.Z1_F_K,'String',num2str(Z1_F_K));
Z1_F_Ti = evalin('base','PID_Z1_F.Ti');
set(handles.Z1_F_Ti,'String',num2str(Z1_F_Ti));
Z1_F_Td = evalin('base','PID_Z1_F.Td');
set(handles.Z1_F_Td,'String',num2str(Z1_F_Td));
Z1_F_Tpr = evalin('base','PID_Z1_F.Tpr');
set(handles.Z1_F_Tpr,'String',num2str(Z1_F_Tpr));

% - zawory kondygnacji 2 - petla sp. z T
Z2_T_K = evalin('base','PID_Z2_T.K');
set(handles.Z2_T_K,'String',num2str(Z2_T_K));
Z2_T_Ti = evalin('base','PID_Z2_T.Ti');
set(handles.Z2_T_Ti,'String',num2str(Z2_T_Ti));
Z2_T_Td = evalin('base','PID_Z2_T.Td');
set(handles.Z2_T_Td,'String',num2str(Z2_T_Td));
Z2_T_Tpr = evalin('base','PID_Z2_T.Tpr');
set(handles.Z2_T_Tpr,'String',num2str(Z2_T_Tpr));
% - zawory kondygnacji 2 - petla sp. z F
Z2_F_K = evalin('base','PID_Z2_F.K');
set(handles.Z2_F_K,'String',num2str(Z2_F_K));
Z2_F_Ti = evalin('base','PID_Z2_F.Ti');
set(handles.Z2_F_Ti,'String',num2str(Z2_F_Ti));
Z2_F_Td = evalin('base','PID_Z2_F.Td');
set(handles.Z2_F_Td,'String',num2str(Z2_F_Td));
Z2_F_Tpr = evalin('base','PID_Z2_F.Tpr');
set(handles.Z2_F_Tpr,'String',num2str(Z2_F_Tpr));

% - zawory kondygnacji 3 - petla sp. z T
Z3_T_K = evalin('base','PID_Z3_T.K');
set(handles.Z3_T_K,'String',num2str(Z3_T_K));
Z3_T_Ti = evalin('base','PID_Z3_T.Ti');
set(handles.Z3_T_Ti,'String',num2str(Z3_T_Ti));
Z3_T_Td = evalin('base','PID_Z3_T.Td');
set(handles.Z3_T_Td,'String',num2str(Z3_T_Td));
Z3_T_Tpr = evalin('base','PID_Z3_T.Tpr');
set(handles.Z3_T_Tpr,'String',num2str(Z3_T_Tpr));
% - zawory kondygnacji 3 - petla sp. z F
Z3_F_K = evalin('base','PID_Z3_F.K');
set(handles.Z3_F_K,'String',num2str(Z3_F_K));
Z3_F_Ti = evalin('base','PID_Z3_F.Ti');
set(handles.Z3_F_Ti,'String',num2str(Z3_F_Ti));
Z3_F_Td = evalin('base','PID_Z3_F.Td');
set(handles.Z3_F_Td,'String',num2str(Z3_F_Td));
Z3_F_Tpr = evalin('base','PID_Z3_F.Tpr');
set(handles.Z3_F_Tpr,'String',num2str(Z3_F_Tpr));

guidata(hObject, handles); % updates handles structure

% --- Outputs from this function are returned to the command line.
function varargout = HMI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function T1_PV_Callback(hObject, eventdata, handles)
% hObject    handle to T1_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1_PV as text
%        str2double(get(hObject,'String')) returns contents of T1_PV as a double


% --- Executes during object creation, after setting all properties.
function T1_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fan_K_Callback(hObject, eventdata, handles)
% hObject    handle to Fan_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fan_K as text
%        str2double(get(hObject,'String')) returns contents of Fan_K as a double
    

% --- Executes during object creation, after setting all properties.
function Fan_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fan_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fan_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Fan_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fan_Ti as text
%        str2double(get(hObject,'String')) returns contents of Fan_Ti as a double


% --- Executes during object creation, after setting all properties.
function Fan_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fan_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fan_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Fan_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fan_Td as text
%        str2double(get(hObject,'String')) returns contents of Fan_Td as a double


% --- Executes during object creation, after setting all properties.
function Fan_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fan_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Fan_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Fan_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Fan_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Fan_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Fan_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Fan_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Fan_reTune.
function Fan_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Fan_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Fan_K,'String'));
    Ti = str2num(get(handles.Fan_Ti,'String'));
    Td = str2num(get(handles.Fan_Td,'String'));
    Tpr = str2num(get(handles.Fan_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_wentylator.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_wentylator.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_wentylator.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_wentylator.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_wentylator.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');


function Heater_K_Callback(hObject, eventdata, handles)
% hObject    handle to Heater_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Heater_K as text
%        str2double(get(hObject,'String')) returns contents of Heater_K as a double


% --- Executes during object creation, after setting all properties.
function Heater_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Heater_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Heater_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Heater_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Heater_Ti as text
%        str2double(get(hObject,'String')) returns contents of Heater_Ti as a double


% --- Executes during object creation, after setting all properties.
function Heater_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Heater_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Heater_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Heater_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Heater_Td as text
%        str2double(get(hObject,'String')) returns contents of Heater_Td as a double


% --- Executes during object creation, after setting all properties.
function Heater_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Heater_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Heater_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Heater_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Heater_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Heater_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Heater_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Heater_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Heater_reTune.
function Heater_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Heater_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Heater_K,'String'));
    Ti = str2num(get(handles.Heater_Ti,'String'));
    Td = str2num(get(handles.Heater_Td,'String'));
    Tpr = str2num(get(handles.Heater_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_grzalka.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_grzalka.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_grzalka.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_grzalka.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_grzalka.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');


function Z1_F_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_F_K as text
%        str2double(get(hObject,'String')) returns contents of Z1_F_K as a double


% --- Executes during object creation, after setting all properties.
function Z1_F_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_F_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_F_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z1_F_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z1_F_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_F_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_F_Td as text
%        str2double(get(hObject,'String')) returns contents of Z1_F_Td as a double


% --- Executes during object creation, after setting all properties.
function Z1_F_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_F_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_F_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z1_F_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z1_F_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Z1_F_reTune.
function Z1_F_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_F_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z1_F_K,'String'));
    Ti = str2num(get(handles.Z1_F_Ti,'String'));
    Td = str2num(get(handles.Z1_F_Td,'String'));
    Tpr = str2num(get(handles.Z1_F_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z1_F.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z1_F.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z1_F.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z1_F.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z1_F.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');

% --- Executes on button press in Z1_T_reTune.
function Z1_T_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_T_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z1_T_K,'String'));
    Ti = str2num(get(handles.Z1_T_Ti,'String'));
    Td = str2num(get(handles.Z1_T_Td,'String'));
    Tpr = str2num(get(handles.Z1_T_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z1_T.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z1_T.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z1_T.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z1_T.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z1_T.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');


function Z1_T_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_T_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z1_T_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z1_T_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_T_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_T_Td as text
%        str2double(get(hObject,'String')) returns contents of Z1_T_Td as a double


% --- Executes during object creation, after setting all properties.
function Z1_T_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_T_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_T_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z1_T_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z1_T_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z1_T_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z1_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z1_T_K as text
%        str2double(get(hObject,'String')) returns contents of Z1_T_K as a double


% --- Executes during object creation, after setting all properties.
function Z1_T_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z1_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_F_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_F_K as text
%        str2double(get(hObject,'String')) returns contents of Z2_F_K as a double


% --- Executes during object creation, after setting all properties.
function Z2_F_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_F_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_F_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z2_F_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z2_F_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_F_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_F_Td as text
%        str2double(get(hObject,'String')) returns contents of Z2_F_Td as a double


% --- Executes during object creation, after setting all properties.
function Z2_F_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_F_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_F_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z2_F_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z2_F_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Z2_F_reTune.
function Z2_F_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_F_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z2_F_K,'String'));
    Ti = str2num(get(handles.Z2_F_Ti,'String'));
    Td = str2num(get(handles.Z2_F_Td,'String'));
    Tpr = str2num(get(handles.Z2_F_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z2_F.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z2_F.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z2_F.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z2_F.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z2_F.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');

% --- Executes on button press in Z2_T_reTune.
function Z2_T_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_T_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z2_T_K,'String'));
    Ti = str2num(get(handles.Z2_T_Ti,'String'));
    Td = str2num(get(handles.Z2_T_Td,'String'));
    Tpr = str2num(get(handles.Z2_T_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z2_T.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z2_T.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z2_T.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z2_T.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z2_T.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');


function Z2_T_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_T_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z2_T_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z2_T_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_T_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_T_Td as text
%        str2double(get(hObject,'String')) returns contents of Z2_T_Td as a double


% --- Executes during object creation, after setting all properties.
function Z2_T_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_T_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_T_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z2_T_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z2_T_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z2_T_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z2_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z2_T_K as text
%        str2double(get(hObject,'String')) returns contents of Z2_T_K as a double


% --- Executes during object creation, after setting all properties.
function Z2_T_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z2_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_F_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_F_K as text
%        str2double(get(hObject,'String')) returns contents of Z3_F_K as a double


% --- Executes during object creation, after setting all properties.
function Z3_F_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_F_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_F_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_F_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z3_F_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z3_F_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_F_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_F_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_F_Td as text
%        str2double(get(hObject,'String')) returns contents of Z3_F_Td as a double


% --- Executes during object creation, after setting all properties.
function Z3_F_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_F_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_F_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_F_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z3_F_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z3_F_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_F_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z3_F_K,'String'));
    Ti = str2num(get(handles.Z3_F_Ti,'String'));
    Td = str2num(get(handles.Z3_F_Td,'String'));
    Tpr = str2num(get(handles.Z3_F_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z3_F.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z3_F.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z3_F.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z3_F.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z3_F.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');


% --- Executes on button press in Z3_T_reTune.
function Z3_T_reTune_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_T_reTune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    K = str2num(get(handles.Z3_T_K,'String'));
    Ti = str2num(get(handles.Z3_T_Ti,'String'));
    Td = str2num(get(handles.Z3_T_Td,'String'));
    Tpr = str2num(get(handles.Z3_T_Tpr,'String'));
    
    assignin('base','HMI_temp',K);
    evalin('base', 'HMI_PID_Z3_T.K = HMI_temp;');
    
    assignin('base','HMI_temp',Ti);
    evalin('base', 'HMI_PID_Z3_T.Ti = HMI_temp;');
    
    assignin('base','HMI_temp',Td);
    evalin('base', 'HMI_PID_Z3_T.Td = HMI_temp;');
    
    assignin('base','HMI_temp',Tpr);
    evalin('base', 'HMI_PID_Z3_T.Tpr = HMI_temp;');
    
    evalin('base', 'HMI_PID_Z3_T.reTune = 1;');
    
    % przepisanie ze strukturki HMI na PIDy
    evalin('base', 'HMI_EXCHANGE');

function Z3_T_Tpr_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_T_Tpr as text
%        str2double(get(hObject,'String')) returns contents of Z3_T_Tpr as a double


% --- Executes during object creation, after setting all properties.
function Z3_T_Tpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_T_Tpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_T_Td_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_T_Td as text
%        str2double(get(hObject,'String')) returns contents of Z3_T_Td as a double


% --- Executes during object creation, after setting all properties.
function Z3_T_Td_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_T_Td (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_T_Ti_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_T_Ti as text
%        str2double(get(hObject,'String')) returns contents of Z3_T_Ti as a double


% --- Executes during object creation, after setting all properties.
function Z3_T_Ti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_T_Ti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Z3_T_K_Callback(hObject, eventdata, handles)
% hObject    handle to Z3_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Z3_T_K as text
%        str2double(get(hObject,'String')) returns contents of Z3_T_K as a double


% --- Executes during object creation, after setting all properties.
function Z3_T_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Z3_T_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F1_PV_Callback(hObject, eventdata, handles)
% hObject    handle to F1_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F1_PV as text
%        str2double(get(hObject,'String')) returns contents of F1_PV as a double


% --- Executes during object creation, after setting all properties.
function F1_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F1_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_PV_Callback(hObject, eventdata, handles)
% hObject    handle to T2_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2_PV as text
%        str2double(get(hObject,'String')) returns contents of T2_PV as a double


% --- Executes during object creation, after setting all properties.
function T2_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F2_PV_Callback(hObject, eventdata, handles)
% hObject    handle to F2_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F2_PV as text
%        str2double(get(hObject,'String')) returns contents of F2_PV as a double


% --- Executes during object creation, after setting all properties.
function F2_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F2_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T3_PV_Callback(hObject, eventdata, handles)
% hObject    handle to T3_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T3_PV as text
%        str2double(get(hObject,'String')) returns contents of T3_PV as a double


% --- Executes during object creation, after setting all properties.
function T3_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T3_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F3_PV_Callback(hObject, eventdata, handles)
% hObject    handle to F3_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F3_PV as text
%        str2double(get(hObject,'String')) returns contents of F3_PV as a double


% --- Executes during object creation, after setting all properties.
function F3_PV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F3_PV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T1_SP_Callback(hObject, eventdata, handles)
% hObject    handle to T1_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T1_SP as text
%        str2double(get(hObject,'String')) returns contents of T1_SP as a double


% --- Executes during object creation, after setting all properties.
function T1_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F1_SP_Callback(hObject, eventdata, handles)
% hObject    handle to F1_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F1_SP as text
%        str2double(get(hObject,'String')) returns contents of F1_SP as a double


% --- Executes during object creation, after setting all properties.
function F1_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F1_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T2_SP_Callback(hObject, eventdata, handles)
% hObject    handle to T2_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T2_SP as text
%        str2double(get(hObject,'String')) returns contents of T2_SP as a double


% --- Executes during object creation, after setting all properties.
function T2_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F2_SP_Callback(hObject, eventdata, handles)
% hObject    handle to F2_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F2_SP as text
%        str2double(get(hObject,'String')) returns contents of F2_SP as a double


% --- Executes during object creation, after setting all properties.
function F2_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F2_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T3_SP_Callback(hObject, eventdata, handles)
% hObject    handle to T3_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T3_SP as text
%        str2double(get(hObject,'String')) returns contents of T3_SP as a double


% --- Executes during object creation, after setting all properties.
function T3_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T3_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F3_SP_Callback(hObject, eventdata, handles)
% hObject    handle to F3_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F3_SP as text
%        str2double(get(hObject,'String')) returns contents of F3_SP as a double


% --- Executes during object creation, after setting all properties.
function F3_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F3_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tamb_SP_Callback(hObject, eventdata, handles)
% hObject    handle to Tamb_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tamb_SP as text
%        str2double(get(hObject,'String')) returns contents of Tamb_SP as a double


% --- Executes during object creation, after setting all properties.
function Tamb_SP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tamb_SP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbStart.
function rbStart_Callback(hObject, eventdata, handles)
% hObject    handle to rbStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnSaveSP.
function btnSaveSP_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveSP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    T1_SP = str2num(get(handles.T1_SP,'String'));
    T2_SP = str2num(get(handles.T2_SP,'String'));
    T3_SP = str2num(get(handles.T3_SP,'String'));
    
    F1_SP = str2num(get(handles.F1_SP,'String'));
    F2_SP = str2num(get(handles.F2_SP,'String'));
    F3_SP = str2num(get(handles.F3_SP,'String'));
    
    T_amb = str2num(get(handles.Tamb_SP,'String'));
    
    assignin('base','T1_SP',T1_SP);
    assignin('base','T2_SP',T2_SP);
    assignin('base','T3_SP',T3_SP);
    
    assignin('base','F1_SP',F1_SP);
    assignin('base','F2_SP',F2_SP);
    assignin('base','F3_SP',F3_SP);
    
    assignin('base','Tamb',T_amb);


function com_port_name_Callback(hObject, eventdata, handles)
% hObject    handle to com_port_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of com_port_name as text
%        str2double(get(hObject,'String')) returns contents of com_port_name as a double


% --- Executes during object creation, after setting all properties.
function com_port_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to com_port_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loop_interval_Callback(hObject, eventdata, handles)
% hObject    handle to loop_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loop_interval as text
%        str2double(get(hObject,'String')) returns contents of loop_interval as a double


% --- Executes during object creation, after setting all properties.
function loop_interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loop_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in cbStart.
function cbStart_Callback(hObject, eventdata, handles)
% hObject    handle to cbStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    dT = str2num(get(handles.loop_interval,'String'));
    
    % prze³¹czenie OFF -> ON
    if get(hObject,'Value') == 1
        set(handles.cbStart,'String','Stop Main Programm Loop');
        set(handles.rbCooling,'Enable','off');
        guidata(hObject, handles); % updates handles structure
    else
        set(handles.cbStart,'String','Start Main Programm Loop');
        set(handles.rbCooling,'Enable','on');
        guidata(hObject, handles); % updates handles structure
    end
% pêtla realizuje siê gdy przycisk jest wciœniêty
while  get(hObject,'Value')
    % cykliczne wywo³ania skryptu przeliczaj¹cego strukturê regulacji
    evalin('base','SKRYPCIK');
    
    % zaczytanie wartœci PV
    T1_PV = evalin('base','T1_PV');
    T2_PV = evalin('base','T2_PV');
    T3_PV = evalin('base','T3_PV');
    
    F1_PV = evalin('base','F1_PV');
    F2_PV = evalin('base','F2_PV');
    F3_PV = evalin('base','F3_PV');
    
    set(handles.T1_PV,'String',num2str(T1_PV));
    set(handles.T2_PV,'String',num2str(T2_PV));
    set(handles.T3_PV,'String',num2str(T3_PV));
    
    set(handles.F1_PV,'String',num2str(F1_PV));
    set(handles.F2_PV,'String',num2str(F2_PV));
    set(handles.F3_PV,'String',num2str(F3_PV));
    guidata(hObject, handles); % updates handles structure
    
    pause(dT);
end
guidata(hObject, handles); % updates handles structure


% --- Executes on button press in rbCooling.
function rbCooling_Callback(hObject, eventdata, handles)
% hObject    handle to rbCooling (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbCooling
    if get(hObject,'Value') == 1
            % wprowadzenie uk³adu w stan spoczynkowy
            evalin('base','rury.nest()');
            %wentylator na 95%
            evalin('base','rury.SetW(95)');
    else
            evalin('base','rury.nest()');
    end