function [outdata] = ECFMFbend(para)
%
% ECFMFbend.m
%
% Model exported on Dec 29 2015, 17:20 by COMSOL 5.1.0.136.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath(['E:\Users\kklong\Documents\' native2unicode(hex2dec({'76' '7e'}), 'unicode')  native2unicode(hex2dec({'5e' 'a6'}), 'unicode')  native2unicode(hex2dec({'4e' '91'}), 'unicode') '\Simulation Work\EC-FMF\cutoff']);

model.label('ECFMFbend.mph');

model.comments(['Step-Index Fiber Bend\n\nA step index fiber bent into a 3 mm radius is analyzed with respect to propagating modes and radiation loss. It is shown how to find the power averaged mode radius and how to use this to compute the effective mode index.']);

model.param.set('wl', para.Wavelength, 'Wavelength');
model.param.set('f0', 'c_const/wl', 'Frequency');
model.param.set('nClad', '1.44447', 'Refractive index, cladding');
model.param.set('nCore', 'nClad*(1+det)', 'Refractive index, core');
model.param.set('aCore', '7.7[um]/2', 'Core radius');
model.param.set('aClad', '62.5[um]', 'Cladding radius');
model.param.set('R', para.BendR, 'Bend radius');
model.param.set('aSquare', '145[um]+tPML*2', 'Side length of square');
model.param.set('tPML', '40[um]', 'PML thickness');
model.param.set('dr', 'aSquare/2-tPML', 'Distance from core center to PML boundary');
model.param.set('wlPML', 'wl/sqrt(nClad^2-(nCore*R/(R+dr))^2)', 'Radial wavelength in PML');
model.param.set('det', '0.0032');
model.param.set('aTrc', '18[um]/2');
model.param.set('aOtr', '29.5[um]/2');
model.param.set('det1', '-0.005');
model.param.set('nTrc', 'nClad*(1+det1)');
model.param.set('pml', 'aClad*1.2');
model.param.set('aCorea', para.aCorea);
model.param.set('aCoreb', para.aCoreb);
model.param.set('RotA', para.RotA);
model.param.set('coreNeff', para.coreNeff);
model.param.set('bAllModeNum', '2');

model.modelNode.create('comp2');
model.modelNode('comp2').label('Bent Fiber');

model.file.clear;

model.geom.create('geom2', 2);
model.geom('geom2').axisymmetric(true);

model.mesh.create('mesh2', 'geom2');

model.geom('geom2').create('c1', 'Circle');
model.geom('geom2').feature('c1').active(false);
model.geom('geom2').feature('c1').label('Core');
model.geom('geom2').feature('c1').set('r', 'aCore');
model.geom('geom2').feature('c1').set('pos', {'R' '0'});
model.geom('geom2').create('sq1', 'Square');
model.geom('geom2').feature('sq1').set('base', 'center');
model.geom('geom2').feature('sq1').set('pos', {'R' '0'});
model.geom('geom2').feature('sq1').set('size', 'aSquare');
model.geom('geom2').create('r1', 'Rectangle');
model.geom('geom2').feature('r1').set('size', {'aSquare' 'tPML'});
model.geom('geom2').feature('r1').set('pos', {'R-aSquare/2' 'aSquare/2-tPML'});
model.geom('geom2').create('r2', 'Rectangle');
model.geom('geom2').feature('r2').set('size', {'tPML' 'aSquare'});
model.geom('geom2').feature('r2').set('pos', {'R+dr' '-aSquare/2'});
model.geom('geom2').create('r3', 'Rectangle');
model.geom('geom2').feature('r3').set('size', {'aSquare' 'tPML'});
model.geom('geom2').feature('r3').set('pos', {'R-aSquare/2' '-aSquare/2'});
model.geom('geom2').create('c2', 'Circle');
model.geom('geom2').feature('c2').active(false);
model.geom('geom2').feature('c2').label('Trc');
model.geom('geom2').feature('c2').set('r', 'aTrc');
model.geom('geom2').feature('c2').set('pos', {'R' '0'});
model.geom('geom2').create('c3', 'Circle');
model.geom('geom2').feature('c3').active(false);
model.geom('geom2').feature('c3').label('Otr');
model.geom('geom2').feature('c3').set('r', 'aOtr');
model.geom('geom2').feature('c3').set('pos', {'R' '0'});
model.geom('geom2').create('e1', 'Ellipse');
model.geom('geom2').feature('e1').set('pos', {'R' '0'});
model.geom('geom2').feature('e1').set('semiaxes', {'aCorea' 'aCoreb'});
model.geom('geom2').feature('e1').set('rot', 'RotA');
model.geom('geom2').create('c4', 'Circle');
model.geom('geom2').feature('c4').label('Otr 1');
model.geom('geom2').feature('c4').set('r', 'aClad');
model.geom('geom2').feature('c4').set('pos', {'R' '0'});
model.geom('geom2').run;

model.variable.create('var1');
model.variable('var1').model('comp2');
model.variable('var1').set('r0', 'intop1(r*ewfd2.Poavphi)/intop1(ewfd2.Poavphi)');

model.view('view1').tag('view2');

model.material.create('mat1', 'Common', '');
model.material.create('mat2', 'Common', '');
model.material.create('matlnk3', 'Link', 'comp2');
model.material.create('matlnk4', 'Link', 'comp2');
model.material.create('mat3', 'Common', '');
model.material.create('matlnk6', 'Link', 'comp2');
model.material('mat1').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('mat2').propertyGroup.create('RefractiveIndex', 'Refractive index');
model.material('matlnk4').selection.set([8]);
model.material('mat3').propertyGroup.create('RefractiveIndex', 'Refractive index');

model.cpl.create('intop1', 'Integration', 'geom2');
model.cpl('intop1').selection.set([2 7 8]);

model.coordSystem('sys1').tag('sys2');
model.coordSystem.create('pml1', 'geom2', 'PML');
model.coordSystem('pml1').selection.set([1 3 4 5 6]);

model.physics.create('ewfd2', 'ElectromagneticWavesFrequencyDomain', 'geom2');
model.physics('ewfd2').identifier('ewfd2');
model.physics('ewfd2').field('electricfield').field('E2');
model.physics('ewfd2').field('electricfield').component({'E2r' 'E2phi' 'E2z'});
model.physics('ewfd2').create('pmc1', 'PerfectMagneticConductor', 1);
model.physics('ewfd2').feature('pmc1').selection.set([1 3 5 15 16 17]);

model.mesh('mesh2').create('ftri1', 'FreeTri');
model.mesh('mesh2').create('map1', 'Map');
model.mesh('mesh2').feature('ftri1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('ftri1').selection.set([2 7 8]);
model.mesh('mesh2').feature('ftri1').create('size1', 'Size');
model.mesh('mesh2').feature('ftri1').feature('size1').selection.set([8]);
model.mesh('mesh2').feature('map1').selection.geom('geom2', 2);
model.mesh('mesh2').feature('map1').selection.set([1 3 4 5 6]);
model.mesh('mesh2').feature('map1').create('size1', 'Size');

model.frame('material1').tag('material2');

model.result.table.create('tbl2', 'Table');
model.result.table.create('tbl4', 'Table');
model.result.table.create('tbl5', 'Table');

model.view('view2').label('View 2');
model.view('view2').axis.set('abstractviewxscale', '5.462154035740241E-7');
model.view('view2').axis.set('ymin', '-6.187443796079606E-5');
model.view('view2').axis.set('xmax', '0.14020667970180511');
model.view('view2').axis.set('abstractviewyscale', '5.462295575853204E-7');
model.view('view2').axis.set('abstractviewbratio', '0.22500251233577728');
model.view('view2').axis.set('abstractviewtratio', '-0.22500081360340118');
model.view('view2').axis.set('abstractviewrratio', '0.2740013003349304');
model.view('view2').axis.set('xmin', '0.13979162275791168');
model.view('view2').axis.set('abstractviewlratio', '-0.27891430258750916');
model.view('view2').axis.set('ymax', '6.1874816310592E-5');

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
model.material('matlnk3').label('Cladding');
model.material('matlnk4').label('Core');
model.material('matlnk4').set('link', 'mat2');
model.material('mat3').label('trc');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', '');
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', '');
model.material('mat3').propertyGroup('RefractiveIndex').set('n', {'nTrc' '0' '0' '0' 'nTrc' '0' '0' '0' 'nTrc'});
model.material('mat3').propertyGroup('RefractiveIndex').set('ki', {'0' '0' '0' '0' '0' '0' '0' '0' '0'});
model.material('matlnk6').label('Trc');
model.material('matlnk6').set('link', 'mat3');

model.coordSystem('sys2').label('Boundary System 2');
model.coordSystem('sys2').set('name', 'sys2');
model.coordSystem('pml1').set('typicalWavelength', 'wlPML');
model.coordSystem('pml1').set('wavelengthSourceType', 'userDefined');
model.coordSystem('pml1').set('ScalingType', 'Cylindrical');
model.coordSystem('pml1').set('stretchingType', 'rational');

model.mesh('mesh2').feature('size').set('hauto', 3);
model.mesh('mesh2').feature('ftri1').feature('size1').set('custom', 'on');
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmaxactive', true);
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmin', '3.75E-8');
model.mesh('mesh2').feature('ftri1').feature('size1').set('hmax', 'wl/nCore/5');
model.mesh('mesh2').feature('ftri1').feature('size1').set('hminactive', false);
model.mesh('mesh2').feature('map1').feature('size1').set('hauto', 1);
model.mesh('mesh2').run;

model.result.table('tbl2').comments('Blossm para 1.2 (imag(ewfd2.neff))');
model.result.table('tbl4').comments('Blossm para 1 (ewfd2.dampzdB/R)');
model.result.table('tbl5').comments('Blossm para (54.5474*abs(imag(ewfd2.neff))/wl/R)');

model.study.create('std2');
model.study('std2').create('mode', 'ModeAnalysis');

model.sol.create('sol2');
model.sol('sol2').study('std2');
model.sol('sol2').attach('std2');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('e1', 'Eigenvalue');

model.study('std2').feature('mode').set('initstudyhide', 'on');
model.study('std2').feature('mode').set('initsolhide', 'on');
model.study('std2').feature('mode').set('solnumhide', 'on');
model.study('std2').feature('mode').set('notstudyhide', 'on');
model.study('std2').feature('mode').set('notsolhide', 'on');
model.study('std2').feature('mode').set('notsolnumhide', 'on');

model.result.dataset.create('dset2', 'Solution');
model.result.dataset.create('dset3', 'Solution');
model.result.dataset.create('rev1', 'Revolve2D');
model.result.dataset('dset3').selection.geom('geom2', 2);
model.result.dataset('dset3').selection.set([2 7 8]);
model.result.dataset('rev1').set('data', 'dset3');
model.result.dataset.remove('dset1');
model.result.numerical.create('gev1', 'EvalGlobal');
model.result.numerical.create('gev2', 'EvalGlobal');
model.result.numerical.create('gev3', 'EvalGlobal');
model.result.numerical.create('gev4', 'EvalGlobal');
model.result.numerical.create('gev5', 'EvalGlobal');
model.result.numerical.create('gev7', 'EvalGlobal');
model.result.numerical.create('gev8', 'EvalGlobal');
model.result.numerical('gev1').set('data', 'dset3');
model.result.numerical('gev1').set('probetag', 'none');
model.result.numerical('gev2').set('data', 'dset3');
model.result.numerical('gev2').set('probetag', 'none');
model.result.numerical('gev3').set('data', 'dset3');
model.result.numerical('gev3').set('probetag', 'none');
model.result.numerical('gev4').set('data', 'dset3');
model.result.numerical('gev4').set('probetag', 'none');
model.result.numerical('gev5').set('data', 'dset3');
model.result.numerical('gev5').set('probetag', 'none');
model.result.numerical('gev7').set('probetag', 'none');
model.result.numerical('gev8').set('probetag', 'none');
model.result.create('pg2', 'PlotGroup2D');
model.result('pg2').set('data', 'dset3');
model.result('pg2').create('surf1', 'Surface');
model.result('pg2').create('arws1', 'ArrowSurface');
model.result.export.create('anim1', 'Animation');
model.result.export.create('data1', 'Data');

model.study('std2').label('Study 2 (Bent Fiber)');
model.study('std2').feature('mode').set('modeFreq', 'f0');
model.study('std2').feature('mode').set('neigs', '2');
model.study('std2').feature('mode').set('shift', 'coreNeff*R');

model.sol('sol2').attach('std2');
model.sol('sol2').feature('e1').set('neigs', '2');
model.sol('sol2').feature('e1').set('shift', 'coreNeff*R');
model.sol('sol2').feature('e1').set('transform', 'effective_mode_index');
model.sol('sol2').feature('e1').set('rtol', '1.0E-13');
model.sol('sol2').feature('e1').feature('aDef').set('complexfun', true);
model.sol('sol2').runAll;

model.result.dataset('dset3').label('Solution 3 (Bent Fiber)');
model.result.dataset('rev1').set('startangle', '-90');
model.result.dataset('rev1').set('revangle', '225');
model.result.numerical('gev1').label('r0');
model.result.numerical('gev1').set('expr', 'r0');
model.result.numerical('gev1').set('descr', '');
model.result.numerical('gev1').set('unit', 'm');
model.result.numerical('gev2').label('n_eff_geometry');
model.result.numerical('gev2').set('expr', 'real(ewfd2.neff)/r0');
model.result.numerical('gev2').set('descr', 'real(ewfd2.neff)/r0');
model.result.numerical('gev2').set('unit', '1/m');
model.result.numerical('gev3').label('n_eff_power');
model.result.numerical('gev3').set('expr', 'real(ewfd2.neff)/r0');
model.result.numerical('gev3').set('descr', 'real(ewfd2.neff)/r0');
model.result.numerical('gev3').set('unit', '1/m');
model.result.numerical('gev4').label('Blossm');
model.result.numerical('gev4').set('expr', '-54.5474*imag(ewfd2.neff)/wl/R');
model.result.numerical('gev4').set('descr', '-54.5474*imag(ewfd2.neff)/wl/R');
model.result.numerical('gev4').set('unit', '1/m^2');
model.result.numerical('gev5').label('Blossturn');
model.result.numerical('gev5').set('expr', '-54.5474*imag(ewfd2.neff)*2*pi/wl');
model.result.numerical('gev5').set('descr', '-54.5474*imag(ewfd2.neff)*2*pi/wl');
model.result.numerical('gev5').set('unit', '1/m');
model.result.numerical('gev7').label('Blossm para');
model.result.numerical('gev7').set('expr', '54.5474*abs(imag(ewfd2.neff))/wl/R');
model.result.numerical('gev7').set('descr', 'bloss(dB/m)');
model.result.numerical('gev7').set('table', 'tbl5');
model.result.numerical('gev7').set('unit', '1/m^2');
model.result.numerical('gev7').set('descractive', true);
model.result.numerical('gev8').label('BlossdBM');
model.result.numerical('gev8').set('expr', '54.5474*abs(imag(ewfd2.neff))/wl/R');
model.result.numerical('gev8').set('descr', 'bloss(dB/m)');
model.result.numerical('gev8').set('table', 'tbl5');
model.result.numerical('gev8').set('unit', '1/m^2');
model.result.numerical('gev8').set('descractive', true);
model.result.numerical('gev7').setResult;
model.result.numerical('gev8').appendResult;
model.result('pg2').label('Bent Fiber');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').feature('surf1').set('colortable', 'Wave');
model.result('pg2').feature('surf1').set('colorlegend', false);
model.result('pg2').feature('arws1').set('color', 'black');
model.result('pg2').feature('arws1').set('scale', '1.8550681688164065E-6');
model.result('pg2').feature('arws1').set('expr', {'ewfd2.Er' 'ewfd2.Ez'});
model.result('pg2').feature('arws1').set('descr', 'Electric field');
model.result('pg2').feature('arws1').set('arrowlength', 'logarithmic');
model.result('pg2').feature('arws1').set('scaleactive', false);
model.result.export('anim1').set('target', 'player');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('customcolor', {'1' '1' '1'});
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('options', 'off');
model.result.export('anim1').set('sweeptype', 'dde');
model.result.export('anim1').set('title', 'on');
model.result.export('anim1').set('legend', 'on');
model.result.export('anim1').set('logo', 'off');
model.result.export('anim1').set('options', 'off');
model.result.export('anim1').set('fontsize', '9');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes', 'on');
model.result.export('data1').set('descr', {'Electric field norm'});
model.result.export('data1').set('expr', {'ewfd2.normE'});
model.result.export('data1').set('filename', ['E:\Users\kklong\Documents\' native2unicode(hex2dec({'76' '7e'}), 'unicode')  native2unicode(hex2dec({'5e' 'a6'}), 'unicode')  native2unicode(hex2dec({'4e' '91'}), 'unicode') '\Simulation Work\EC-FMF\cutoff\plot.csv']);
model.result.export('data1').set('gridx2', 'range(R-10[um],0.1[um],R+10[um])');
model.result.export('data1').set('gridstruct', 'grid');
model.result.export('data1').set('gridy2', 'range(-10[um],0.1[um],10[um])');
model.result.export('data1').set('location', 'grid');
model.result.export('data1').set('unit', {'V/m'});

model.sol('sol2').runAll;

model.result('pg2').run;
model.result.export('data1').run;

out = model;
outdata.BlossdBM = mphglobal(model,'54.5474*abs(imag(ewfd2.neff))/wl/R');