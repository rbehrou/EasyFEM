function FeTopo = generateTopo3D(MeshParams)
% generate 3D connectivity matrix for the structured domain
%
%---------------------inputs:
%                 MeshParams: geometry properties
%   MeshParams.ControlPoints: Domain control points,
%                             format: 3D: [Xmin Xmax; Ymin Ymax; Zmin Zmax]
%     MeshParams.NumElemsXYZ: Number of elements in each direction
%                             in the domain, format: 3D: [XDir YDir ZDir]
%
%--------------------outputs:
%                     FeTopo: FE elemental connectivity [size: (NumFeElems,8)]
%
%
%% step-1: get the geometry information
NumElemsXDir = MeshParams.NumElemsXYZ(1,1);
NumElemsYDir = MeshParams.NumElemsXYZ(1,2);
NumElemsZDir = MeshParams.NumElemsXYZ(1,3);
NumNodesXDir = NumElemsXDir + 1;
NumNodesYDir = NumElemsYDir + 1;

%% step-2: generate nodal local pattern
incr_xdir    = 1;
incr_ydir    = NumNodesXDir;
incr_zdir    = NumNodesXDir*NumNodesYDir;
node_pattern = [1  2  NumNodesXDir+2  NumNodesXDir+1 ...
                incr_zdir+1 incr_zdir+2 ...
                incr_zdir+NumNodesXDir+2 incr_zdir+NumNodesXDir+1];

%% step-3-1: initialize and get the connectivity matrix
incr   = 0;
el     = 1;
FeTopo = zeros(NumElemsXDir*NumElemsYDir*NumElemsZDir,size(node_pattern,2));

%% step-3-2: main loop over NumElemsZDir, NumElemsYDir, and NumElemsXDir
for zdir = 1:NumElemsZDir
    for row = 1:NumElemsYDir
        for col = 1:NumElemsXDir
            % store connectivity and do increment
            FeTopo(el,:) = node_pattern + incr;
            incr = incr + incr_xdir;
            el = el + 1;
        end
        incr = row * incr_ydir + (zdir - 1) * incr_zdir;
    end
    incr = zdir * incr_zdir;
end

end % end of generateTopo3D