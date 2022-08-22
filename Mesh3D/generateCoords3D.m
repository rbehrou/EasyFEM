function [FeCoord] = generateCoords3D(MeshParams)
%
%% step-1: get the geometry information
ControlPoints = MeshParams.ControlPoints;
NumNodesXDir  = MeshParams.NumElemsXYZ(1,1) + 1;
NumNodesYDir  = MeshParams.NumElemsXYZ(1,2) + 1;
NumNodesZDir  = MeshParams.NumElemsXYZ(1,3) + 1;

%% step-2: generate equally distanced points using linspace
x_pts = linspace(ControlPoints(1,1),ControlPoints(1,2),NumNodesXDir);
y_pts = linspace(ControlPoints(2,1),ControlPoints(2,2),NumNodesYDir);
z_pts = linspace(ControlPoints(3,1),ControlPoints(3,2),NumNodesZDir);

%% step-3: generate grid using meshgrid
[x_grid,y_grid,z_grid] = meshgrid(x_pts,y_pts,z_pts);

%% step-4: reshape and get the finalized coordinates
Xgrid = [];
Ygrid = [];
Zgrid = [];
for i = 1:NumNodesZDir
    Xgrid = [Xgrid;(reshape(x_grid(:,:,i)',[],1))];
    Ygrid = [Ygrid;(reshape(y_grid(:,:,i)',[],1))];
    Zgrid = [Zgrid;(reshape(z_grid(:,:,i)',[],1))];
end

% get the finalized reshaped coordinates
FeCoord = [Xgrid Ygrid Zgrid];

end % end of generateCoords3D