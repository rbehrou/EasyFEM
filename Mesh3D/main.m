
%% some cleaning stuff
clc;
clear;
close all;
clear global

%% mesh generation information for 3D domain
MeshParams.ControlPoints = [0 1;0 1;0 2];
MeshParams.NumElemsXYZ   = [4 3 5];

%% call routines
FeCoord = generateCoords3D(MeshParams);
FeTopo = generateTopo3D(MeshParams);
plotMesh3D(FeCoord,FeTopo)

