%% some cleaning stuff
clc;
clear;
close all;
clear global

%% mesh generation information for 2D domain
MeshParams.ControlPoints = [0 1;0 1];
MeshParams.NumElemsXYZ   = [4 3];

%% call routines
FeCoord = generateCoords2D(MeshParams);
FeTopo = generateTopo2D(MeshParams);
plotMesh2D(FeCoord,FeTopo)

