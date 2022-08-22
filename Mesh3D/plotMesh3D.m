function plotMesh3D(FeCoord,FeTopo)
% function for 3D visualization of mesh
%
%-----------------inputs:
%                FeCoord: FE nodal coordinates
%                 FeTopo: FE connectivity matrix
%
%
%% step-1: set plotting properties
se = 'm-';
hold on

%% step-2: set element local ordering
elem_order = [1 2 3 4 1;...
              5 6 7 8 5;...
              1 2 6 5 1;...
              4 3 7 8 4;...
              4 1 5 8 4;...
              3 2 6 7 3];

%% step-3: loop over number of elements
for el = 1:size(FeTopo,1)
    % loop over elemental local ordering to fill each face
    for il = 1:size(elem_order,1)
        % get elemental coordinates (x, y, z) 
        xpt = FeCoord(FeTopo(el,elem_order(il,:)),1);
        ypt = FeCoord(FeTopo(el,elem_order(il,:)),2);
        zpt = FeCoord(FeTopo(el,elem_order(il,:)),3);
        
        % plot the current element using fill function
        h = fill3(xpt,ypt,zpt,se);
        set(h,'LineWidth',2.0);
    end
end

%% step-4: set plot properties
rotate3d on; axis equal;
xlabel('x'); ylabel('y'); zlabel('z') 
% set(gca,'visible','off')
hold off

end % end of plotMesh3D