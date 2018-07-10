# H2020 ESROCOS Project
# Company: GMV Aerospace & Defence S.A.U.
# Licence: GPLv2

from __future__ import print_function

import os, sys, shutil
import rospkg

from mako.template import Template
from mako.exceptions import text_error_template
from subprocess import call

from .ErrorCodes import ErrorCodes
from .ivData import IvData
from . import typeConvert


def generate(binDir, funcName, outDir):
    '''
    Generate a rospy module that provides a bridge to with TASTE
    :binDir: path of the binary.c folder of the model
    :funcName: TASTE function from which the bridge will be generated (it must be a GUI)
    :outDir: output directory where the ROS node is created
    :return: OK or ErrorCode
    '''
    if not check_binary_folder(binDir, funcName):
        return ErrorCodes.ARGS_ERROR.value
        
    if not check_taste_model(binDir, funcName):
        return ErrorCodes.MODEL_ERROR.value

    if not os.path.exists(outDir):
        try:
            os.makedirs(outDir)
        except OSError as ex:
            perror('Cannot create directory {}: {}'.format(outDir, ex.strerror))
            return ErrorCodes.SYSCMD_ERROR.value
        
    elif not os.path.isdir(outDir):
        perror('{} is not a directory.'.format(outDir))
        return ErrorCodes.SYSCMD_ERROR.value
        
    # Load iv.py
    ivpy = os.path.join(binDir, 'iv.py')
    try:
        ivObj = IvData(ivpy)
    except Exception as ex:
        perror('Cannot load the Interface View data from {}.'.format(ivpy))
        return ErrorCodes.MODEL_ERROR.value
    
    # Check function characteristics
    if not check_function(ivObj, funcName):
        return ErrorCodes.MODEL_ERROR.value

    # Copy TASTE Python files to output folder
    tasteDir = os.path.join(outDir, 'tasteInterface')
    if not os.path.exists(tasteDir):
        try:
            os.makedirs(tasteDir)
        except OSError as ex:
            perror('Cannot create directory {}: {}'.format(tasteDir, ex.strerror))
            return ErrorCodes.SYSCMD_ERROR.value

    guiDir = gui_module(binDir, funcName)
    try:
        for fname in os.listdir(guiDir):
            shutil.copy(os.path.join(guiDir, fname), tasteDir)
    except OSError as ex:
        perror('Cannot copy TASTE Python files from {} to {}: {}'.format(guiDir, tasteDir, ex.strerror))
        return ErrorCodes.SYSCMD_ERROR.value
        
    try:
        initpy = os.path.join(tasteDir, '__init__.py')
        if not os.path.exists(initpy):
            with open(initpy, 'w') as fd:
                fd.close()
    except Exception as ex:
        perror('Cannot create {}: {}.'.format(initpy, ex))
        return ErrorCodes.SYSCMD_ERROR.value
        
    # Generate code with Mako
    scriptDir = os.path.dirname(os.path.realpath(__file__))
    makoFile = os.path.join(scriptDir, 'templates', 'bridge.py.mako')
    
    return render_bridge_template(ivObj, funcName, makoFile, outDir)


def check_binary_folder(binDir, funcName):
    '''
    Check that the contents of binary folder exists.
    '''
    # Check binary.c folder
    if not os.path.exists(binDir):
        perror('The TASTE model binary folder {} does not exist.'.format(binDir))
        return False
        
    elif not os.path.isdir(binDir):
        perror('{} is not a directory.'.format(binDir))
        return False
        
    return True


def check_taste_model(binDir, funcName):
    '''
    Check that the TASTE model with the given binary folder is valid for 
    the generation of a bridge function. 
    '''
    # Check iv.py
    ivpy = os.path.join(binDir, 'iv.py')
    if not os.path.isfile(ivpy):
        perror('File {} not found. Is the TASTE model correctly built, and is {} its build folder?'.format(ivpy, binDir))
        return False
    
    # Check funcName and GUI module
    funcdir = os.path.join(binDir, str.lower(funcName))
    if not os.path.isdir(funcdir):
        perror('Directory {} not found. Is the TASTE model correctly built, and does the model contain a function {}?'.format(funcdir, funcName))
        return False
    
    guiDir = gui_module(binDir, funcName)
    if not os.path.isdir(guiDir):
        perror('Directory {} not found. Is the function {} declared as GUI?'.format(guiDir, funcName))
        return False
        
    # Try loading the PythonController module
    sys.path.append(guiDir)
    try:
        import PythonController
    except ImportError as ex:
        perror('Cannot load PythonController module for {} (from {}). Is the model correctly built?'.format(funcName, guiDir))
        return False

    return True
    

def gui_module(binDir, funcName):
    '''
    Returns the name of the TASTE folder containing the Python module
    for a GUI function.
    '''
    return os.path.join(binDir, 'binaries', str.lower(funcName) + '-GUI')


def check_function(ivObj, funcName):
    '''
    Check if the function is compatible for ROS bridge generation.
    '''
   
    # Check that the interfaces of the function are valid for bridge generation
    if not funcName in ivObj.list_functions():
        perror('Function {} does not exist in the model.'.format(funcName))
        return False
        
    for iface in ivObj.list_interfaces(funcName):
        if len(ivObj.list_in_params(funcName, iface)) != 1 or len(ivObj.list_out_params(funcName, iface)) != 0:
            perror('The parameters of interface {} of function {} are not valid. Bridge function interfaces must have exactly one input parameter.'.format(iface, funcName))
            return False
        else:
            param = ivObj.get_in_param_idx(funcName, iface, 0)
            paramType = ivObj.get_in_param_type(funcName, iface, param)
            if not is_ros_type(paramType):
                perror('The interface {}, function {}, receives a type {}, which is not a known ROS type.'.format(iface, funcName, paramType))
                return False
    
    return True
                

def is_ros_type(typeName):
    '''
    Checks if a TASTE type name corresponds to one of the types defined 
    in the current ROS installation.
    '''
    rospack = rospkg.RosPack()
    (found,_,_) = typeConvert.find_ros_type(rospack, typeName)
    
    return found


def render_bridge_template(ivObj, funcName, makoFile, outDir):
    '''
    Generate the Python bridge code.
    '''
    # Render template
    try:
        template = Template(filename=makoFile)
        outTxt = template.render(iv=ivObj, function=funcName)
    except Exception as ex:
        perror('Error generating bridge code: {}.'.format(ex))
        return ErrorCodes.EXCEP_ERROR.value

    # Write file
    try:
        outFile = os.path.join(outDir, str.lower(funcName)+'.py')
        with open(outFile, 'w') as fd:
            fd.write(outTxt)
        os.chmod(outFile, 0o755)
    except Exception as ex:
        perror('Error writing bridge code to {}: {}.'.format(outFile, ex))
        return ErrorCodes.SYSCMD_ERROR.value
        
    return ErrorCodes.OK.value



def perror(msg):
    '''Print a message to stderr'''
    print(msg, file=sys.stderr)


