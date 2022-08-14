function FeCoord = generateCoords2D(MeshParams)
% generate 2D coordinates for the structured domain
%
%---------------------inputs:
%                 MeshParams: geometry properties
%   MeshParams.ControlPoints: Domain control points,
%                             format: 2D: [Xmin Xmax;Ymin Ymax]
%     MeshParams.NumElemsXYZ: Number of elements in each direction
%                             in the domain, format: 2D: [XDir YDir]
%
%--------------------outputs:
%                    FeCoord: FE nodal coordinates [size: (NumFeNodes,2)]
%
%
%% step-1: get the geometry information
ControlPoints = MeshParams.ControlPoints;
NumNodesXDir = MeshParams.NumElemsXYZ(1,1) + 1;
NumNodesYDir = MeshParams.NumElemsXYZ(1,2) + 1;

%% step-2: generate equally distanced points using linspace
x_vals = linspace(ControlPoints(1,1),ControlPoints(1,2),NumNodesXDir);
y_vals = linspace(ControlPoints(2,1),ControlPoints(2,2),NumNodesYDir);

%% step-3: generate grid using meshgrid
[x_mesh,y_mesh] = meshgrid(x_vals,y_vals);

%% step-4: reshape and get the finalized coordinates
FeCoord = [(reshape(x_mesh',[],1)) (reshape(y_mesh',[],1))];

end