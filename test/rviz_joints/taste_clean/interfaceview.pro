isComponentType('interfaceview::FV::joints_generator','PUBLIC','PI_step','SUBPROGRAM','NIL','').
isComponentImplementation('interfaceview::FV::joints_generator','PUBLIC','PI_step','others','SUBPROGRAM','NIL','others','').
isFeature('ACCESS','interfaceview::IV','joints_generator','PI_step','PROVIDES','SUBPROGRAM','interfaceview::FV::joints_generator::PI_step.others','NIL','NIL','').
isProperty('NIL','=>','interfaceview::FV::joints_generator','PI_step','NIL','NIL','Taste::Associated_Queue_Size','1','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','PI_step','Taste::coordinates','"89131 58425"','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','PI_step','Taste::RCMoperationKind','cyclic','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','PI_step','Taste::RCMperiod','100 ms','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','PI_step','Taste::Deadline','0 ms','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','PI_step','Taste::InterfaceName','"step"','').
isProperty('NIL','=>','interfaceview::FV::joints_generator','PI_step','others','NIL','Compute_Execution_Time','0 ms .. 0 ms','').
isSubcomponent('interfaceview::IV','joints_generator','others','step_impl','SUBPROGRAM','interfaceview::FV::joints_generator::PI_step.others','NIL','NIL','').
isConnection('SUBPROGRAM ACCESS','interfaceview::IV','joints_generator','others','OpToPICnx_step_impl','step_impl','->','PI_step','NIL','').
isConnection('SUBPROGRAM ACCESS','interfaceview::IV','interfaceview','others','joints_bridge_PI_ur5_joints_joints_generator_RI_ur5_joints','joints_bridge.PI_ur5_joints','->','joints_generator.RI_ur5_joints','NIL','').
isProperty('NIL','=>','interfaceview::IV','interfaceview','others','joints_bridge_PI_ur5_joints_joints_generator_RI_ur5_joints','Taste::coordinates','"118265 72600 134721 72600 134721 63937 151177 63937"','').
isComponentType('interfaceview::FV::joints_generator','PUBLIC','RI_ur5_joints','SUBPROGRAM','NIL','').
isComponentImplementation('interfaceview::FV::joints_generator','PUBLIC','RI_ur5_joints','others','SUBPROGRAM','NIL','others','').
isImportDeclaration('interfaceview::IV','PUBLIC','interfaceview::FV::joints_bridge','').
isFeature('ACCESS','interfaceview::IV','joints_generator','RI_ur5_joints','REQUIRES','SUBPROGRAM','interfaceview::FV::joints_bridge::PI_ur5_joints.others','NIL','NIL','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','RI_ur5_joints','Taste::coordinates','"118265 72600"','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','RI_ur5_joints','Taste::RCMoperationKind','any','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','RI_ur5_joints','Taste::InterfaceName','"ur5_joints"','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','RI_ur5_joints','Taste::labelInheritance','"true"','').
isFeature('PARAMETER','interfaceview::FV::joints_generator','RI_ur5_joints','js','IN','NIL','DataView::Sensor_msgs_JointState','NIL','NIL','').
isProperty('NIL','=>','interfaceview::FV::joints_generator','RI_ur5_joints','NIL','js','Taste::encoding','NATIVE','').
isPackage('interfaceview::FV::joints_generator','PUBLIC','').
isComponentType('interfaceview::IV','PUBLIC','joints_generator','SYSTEM','NIL','').
isComponentImplementation('interfaceview::IV','PUBLIC','joints_generator','others','SYSTEM','NIL','others','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','NIL','Source_Language','(C)','').
isProperty('NIL','=>','interfaceview::IV','joints_generator','NIL','NIL','Taste::Active_Interfaces','any','').
isProperty('NIL','=>','interfaceview::IV','interfaceview','others','joints_generator','Taste::coordinates','"89131 52125 118265 82360"','').
isSubcomponent('interfaceview::IV','interfaceview','others','joints_generator','SYSTEM','interfaceview::IV::joints_generator.others','NIL','NIL','').
isImportDeclaration('interfaceview::IV','PUBLIC','interfaceview::FV::joints_generator','').
isImportDeclaration('interfaceview::IV','PUBLIC','Taste','').
isImportDeclaration('interfaceview::FV::joints_generator','PUBLIC','Taste','').
isImportDeclaration('interfaceview::IV','PUBLIC','DataView','').
isImportDeclaration('interfaceview::FV::joints_generator','PUBLIC','DataView','').
isImportDeclaration('interfaceview::FV::joints_generator','PUBLIC','TASTE_IV_Properties','').
isImportDeclaration('interfaceview::IV','PUBLIC','TASTE_IV_Properties','').
isComponentType('interfaceview::FV::joints_bridge','PUBLIC','PI_ur5_joints','SUBPROGRAM','NIL','').
isComponentImplementation('interfaceview::FV::joints_bridge','PUBLIC','PI_ur5_joints','others','SUBPROGRAM','NIL','others','').
isFeature('ACCESS','interfaceview::IV','joints_bridge','PI_ur5_joints','PROVIDES','SUBPROGRAM','interfaceview::FV::joints_bridge::PI_ur5_joints.others','NIL','NIL','').
isProperty('NIL','=>','interfaceview::FV::joints_bridge','PI_ur5_joints','NIL','NIL','Taste::Associated_Queue_Size','1','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','PI_ur5_joints','Taste::coordinates','"151177 63937"','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','PI_ur5_joints','Taste::RCMoperationKind','sporadic','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','PI_ur5_joints','Taste::RCMperiod','0 ms','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','PI_ur5_joints','Taste::Deadline','0 ms','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','PI_ur5_joints','Taste::InterfaceName','"ur5_joints"','').
isFeature('PARAMETER','interfaceview::FV::joints_bridge','PI_ur5_joints','js','IN','NIL','DataView::Sensor_msgs_JointState','NIL','NIL','').
isProperty('NIL','=>','interfaceview::FV::joints_bridge','PI_ur5_joints','NIL','js','Taste::encoding','NATIVE','').
isProperty('NIL','=>','interfaceview::FV::joints_bridge','PI_ur5_joints','others','NIL','Compute_Execution_Time','0 ms .. 0 ms','').
isSubcomponent('interfaceview::IV','joints_bridge','others','ur5_joints_impl','SUBPROGRAM','interfaceview::FV::joints_bridge::PI_ur5_joints.others','NIL','NIL','').
isConnection('SUBPROGRAM ACCESS','interfaceview::IV','joints_bridge','others','OpToPICnx_ur5_joints_impl','ur5_joints_impl','->','PI_ur5_joints','NIL','').
isPackage('interfaceview::FV::joints_bridge','PUBLIC','').
isComponentType('interfaceview::IV','PUBLIC','joints_bridge','SYSTEM','NIL','').
isComponentImplementation('interfaceview::IV','PUBLIC','joints_bridge','others','SYSTEM','NIL','others','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','NIL','Source_Language','(GUI)','').
isProperty('NIL','=>','interfaceview::IV','joints_bridge','NIL','NIL','Taste::Active_Interfaces','any','').
isProperty('NIL','=>','interfaceview::IV','interfaceview','others','joints_bridge','Taste::coordinates','"151177 52912 177318 83462"','').
isSubcomponent('interfaceview::IV','interfaceview','others','joints_bridge','SYSTEM','interfaceview::IV::joints_bridge.others','NIL','NIL','').
isImportDeclaration('interfaceview::FV::joints_bridge','PUBLIC','Taste','').
isImportDeclaration('interfaceview::FV::joints_bridge','PUBLIC','DataView','').
isImportDeclaration('interfaceview::FV::joints_bridge','PUBLIC','TASTE_IV_Properties','').
isProperty('_','_','_','_','_','_','LMP::Unparser_ID_Case','AsIs','').
isProperty('_','_','_','_','_','_','LMP::Unparser_Insert_Header','Yes','').
isPackage('interfaceview::IV','PUBLIC','').
isProperty('NIL','=>','interfaceview::IV','NIL','NIL','NIL','Taste::dataView','("DataView")','').
isProperty('NIL','=>','interfaceview::IV','NIL','NIL','NIL','Taste::dataViewPath','("DataView.aadl")','').
isProperty('NIL','=>','interfaceview::IV','interfaceview','NIL','NIL','Taste::dataView','("DataView")','').
isProperty('NIL','=>','interfaceview::IV','interfaceview','NIL','NIL','Taste::dataViewPath','("DataView.aadl")','').
isVersion('AADL2.1','TASTE type interfaceview','','generated code: do not edit').
isProperty('NIL','=>','interfaceview::IV','NIL','NIL','NIL','Taste::coordinates','"0 0 297000 210000"','').
isProperty('NIL','=>','interfaceview::IV','NIL','NIL','NIL','Taste::version','"1.3"','').
isComponentType('interfaceview::IV','PUBLIC','interfaceview','SYSTEM','NIL','').
isComponentImplementation('interfaceview::IV','PUBLIC','interfaceview','others','SYSTEM','NIL','others','').

