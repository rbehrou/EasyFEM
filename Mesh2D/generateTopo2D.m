function FeTopo = generateTopo2D(MeshParams)
% generate 2D connectivity matrix for the structured domain
%
%---------------------inputs:
%                 MeshParams: geometry properties
%   MeshParams.ControlPoints: Domain control points,
%                             format: 2D: [Xmin Xmax;Ymin Ymax]
%     MeshParams.NumElemsXYZ: Number of elements in each direction
%                             in the domain, format: 2D: [XDir YDir]
%
%--------------------outputs:
%                     FeTopo: FE elemental connectivity [size: (NumFeElems,4)]
%
%
%% step-1: get the geometry information
NumElemsXDir = MeshParams.NumElemsXYZ(1,1);
NumElemsYDir = MeshParams.NumElemsXYZ(1,2);
NumNodesXDir = NumElemsXDir + 1;

%% step-2: generate nodal local pattern
incr_xdir = 1;
incr_ydir = NumNodesXDir;
node_pattern = [1 2 NumNodesXDir+2 NumNodesXDir+1];

%% step-3: initialize and get the connectivity matrix
incr = 0;
el   = 1;
FeTopo = zeros(NumElemsXDir*NumElemsYDir,size(node_pattern,2));

% main loop over NumElemsYDir and NumElemsXDir
for row = 1:NumElemsYDir
    for col = 1:NumElemsXDir
        % store connectivity and do increment
        FeTopo(el,:) = node_pattern + incr;
        incr = incr + incr_xdir;
        el = el + 1;
    end
    incr = row*incr_ydir;
end

end