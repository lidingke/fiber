function [outdata] = ECFMFstraight(para)
%
% ECFMFstraight.m
%
% Model exported on Dec 29 2015, 16:47 by COMSOL 5.1.0.136.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath(['E:\Users\kklong\Documents\' native2unicode(hex2dec({'76' '7e'}), 'unicode')  native2unicode(hex2dec({'5e' 'a6'}), 'unicode')  native2unicode(hex2dec({'4e' '91'}), 'unicode') '\Simulation Work\EC-FMF\cutoffMultibendsweep']);

model.label('ECFMFstraight.mph');

model.comments(['Step-Index Fiber Bend\n\nA step index fiber bent into a 3 mm radius is analyzed with respect to propagating modes and radiation loss. It is shown how to find the power averaged mode radius and how to use this to compute the effective mode index.']);

model.param.set('wl', para.Wavelength, 'Wavelength');
model.param.set('f0', 'c_const/wl', 'Frequency');
model.param.set('nClad', '1.44447', 'Refractive index, cladding');
model.param.set('nCore', 'nClad*(1+det)', 'Refractive index, core');
model.param.set('R', '140[mm]', 'Bend radius');
model.param.set('aSquare', '145[um]+tPML*2', 'Side length of square');
model.param.set('aClad', '62.5[um]');
model.param.set('tPML', '40[um]', 'PML thickness');
model.param.set('dr', 'aSquare/2-tPML', 'Distance from core center to PML boundary');
model.param.set('wlPML', 'wl/sqrt(nClad^2-(nCore*R/(R+dr))^2)', 'Radial wavelength in PML');
model.param.set('det', '0.0032');
model.param.set('pml', 'aClad*1.2');
model.param.set('aCorea', para.aCorea);
model.param.set('aCoreb', para.aCoreb);
model.param.set('RotA', para.RotA);
model.param.set('modeNum', '12');

model.modelNode.create('comp1');
model.modelNode('comp1').label('Straight Fiber');

model.file.clear;

model.geom.create('geom1', 2);

model.mesh.create('mesh1', 'geom1');

model.geom('geom1').create('c1', 'Circle');
model.geom('geom1').feature('c1').label('clad');
model.geom('geom1').feature('c1').set('r', 'aClad');
model.geom('geom1').create('c2', 'Circle');
model.geom('geom1').feature('c2').active(false);
model.geom('geom1').feature('c2').label('core');
model.geom('geom1').feature('c2').set('r', 'aCore');
model.geom('geom1').create('c3', 'Circle');
model.geom('geom1').feature('c3').active(false);
model.geom('geom1').feature('c3').label('Trc');
model.geom('geom1').feature('c3').set('r', 'aTrc');
model.geom('geom1').create('c4', 'Circle');
model.geom('geom1').feature('c4').active(false);
model.geom('geom1').feature('c4').label('Otr');
model.geom('geom1').feature('c4').set('r', 'aOtr');
model.geom('geom1').create('c5', 'Circle');
model.geom('geom1').feature('c5').label('PML');
model.geom('geom1').feature('c5').set('r', 'pml');
model.geom('geom1').create('e1', 'Ellipse');
model.geom('geom1').feature('e1').set('semiaxes', {'aCorea' 'aCoreb'});
model.geom('geom1').feature('e1').set('rot', 'RotA');
model.geom('geom1').run;

model.material.create('mat1', 'Common', '');
model.material.create('mat2', 'Common', '');
model.material.create('matlnk1', 'Link', 'comp1');
model.material.create('matlnk2', 'Link', 'comp1');
model.material.create('mat3', 'Common', '');
model.material.create('matlnk5', 'Link', 'comp1');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('matlnk2').selection.set([3]);
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');

model.coordSystem.create('pml2', 'geom1', 'PML');
model.coordSystem('pml2').selection.set([1]);

model.physics.create('ewfd', 'ElectromagneticWavesFrequencyDomain', 'geom1');

model.mesh('mesh1').autoMeshSize(3);

model.result.table.create('tbl2', 'Table');
model.result.table.create('tbl4', 'Table');
model.result.table.create('tbl5', 'Table');
model.result.table.create('tbl6', 'Table');

model.view('view1').axis.set('abstractviewxscale', '2.562111944826029E-7');
model.view('view1').axis.set('ymin', '-2.062500425381586E-5');
model.view('view1').axis.set('xmax', '6.738355295965448E-5');
model.view('view1').axis.set('abstractviewyscale', '2.562112229043123E-7');
model.view('view1').axis.set('abstractviewbratio', '0.36249998211860657');
model.view('view1').axis.set('abstractviewtratio', '-0.36249998211860657');
model.view('view1').axis.set('abstractviewrratio', '-0.05077638477087021');
model.view('view1').axis.set('xmin', '-6.738355295965448E-5');
model.view('view1').axis.set('abstractviewlratio', '0.05077638477087021');
model.view('view1').axis.set('ymax', '2.062500425381586E-5');

model.material('mat1').label('Silica Glass');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', '');
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', '');
model.material('mat1').propertyGroup('RefractiveIndex').set('n', {'nClad' '0' '0' '0' 'nClad' '0' '0' '0' 'nClad'});
model.material('mat1').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('mat2').label('Doped Silica Glass');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', '');
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', '');
model.material('mat2').propertyGroup('RefractiveIndex').set('n', {'nCore' '0' '0' '0' 'nCore' '0' '0' '0' 'nCore'});
model.material('mat2').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('matlnk1').label('Cladding');
model.material('matlnk2').label('Core');
model.material('matlnk2').set('link', 'mat2');
model.material('mat3').label('trc');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', '');
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', '');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'nTrc' '0' '0' '0' 'nTrc' '0' '0' '0' 'nTrc'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('matlnk5').label('Trc');
model.material('matlnk5').set('link', 'mat3');

model.coordSystem('pml2').set('ScalingType', 'Cylindrical');

model.mesh('mesh1').run;

model.result.table('tbl2').comments('Blossm para 1.2 (imag(ewfd2.neff))');
model.result.table('tbl4').comments('Blossm para 1 (ewfd2.dampzdB/R)');
model.result.table('tbl5').comments('Blossm para (54.5474*abs(imag(ewfd2.neff))/wl/R)');
model.result.table('tbl6').comments('Global Evaluation 1 (ewfd.neff)');

model.study.create('std1');
model.study('std1').create('mode', 'ModeAnalysis');

model.sol.create('sol1');
model.sol('sol1').study('std1');
model.sol('sol1').attach('std1');
model.sol('sol1').create('st1', 'StudyStep');
model.sol('sol1').create('v1', 'Variables');
model.sol('sol1').create('e1', 'Eigenvalue');

model.study('std1').feature('mode').set('initstudyhide', 'on');
model.study('std1').feature('mode').set('initsolhide', 'on');
model.study('std1').feature('mode').set('solnumhide', 'on');
model.study('std1').feature('mode').set('notstudyhide', 'on');
model.study('std1').feature('mode').set('notsolhide', 'on');
model.study('std1').feature('mode').set('notsolnumhide', 'on');

model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical('gev1').set('probetag', 'none');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').create('arws1', 'ArrowSurface');

model.study('std1').label('Study 1 (Straight Fiber)');
model.study('std1').feature('mode').set('modeFreq', 'f0');
model.study('std1').feature('mode').set('neigs', '12');
model.study('std1').feature('mode').set('shift', 'nCore');

model.sol('sol1').attach('std1');
model.sol('sol1').feature('e1').set('neigs', '12');
model.sol('sol1').feature('e1').set('shift', 'nCore');
model.sol('sol1').feature('e1').set('transform', 'effective_mode_index');
model.sol('sol1').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol1').runAll;

model.result.dataset('dset1').label('Solution 1 (Straight Fiber)');
model.result.numerical('gev1').set('expr', 'ewfd.neff');
model.result.numerical('gev1').set('descr', 'ewfd.neff');
model.result.numerical('gev1').set('table', 'tbl6');
model.result.numerical('gev1').set('unit', '1');
model.result.numerical('gev1').setResult;
model.result('pg1').label('neff');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature('arws1').set('color', 'black');
model.result('pg1').feature('arws1').set('scale', '2.1987390815877693E-6');
model.result('pg1').feature('arws1').set('expr', {'ewfd.Ex' 'ewfd.Ey'});
model.result('pg1').feature('arws1').set('descr', 'Electric field');
model.result('pg1').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg1').feature('arws1').set('scaleactive', false);

model.sol('sol1').clearSolution;
model.sol('sol1').runAll;

model.result('pg1').run;

outdata.neff = mphglobal(model,'ewfd.neff');
