function [ MASS ] = generateMassMatrix( mesh, frequency, wv)
%GENERATEMASS Summary of this function goes here
%   Detailed explanation goes here
omega = 2*pi*frequency*1e6;
if strcmp(mesh.type,'spec')
    [mesh.mua, mesh.mus, mesh.kappa] = calc_mua_mus(mesh,wv);
elseif strcmp(mesh.type,'specPenn')
    [mesh.mua, mesh.mus, mesh.kappa] = calc_mua_mus(mesh,wv);
    mesh.mua = mesh.mua + mesh.backgroundMua(:,mesh.wv == wv);
    mesh.kappa = 1./(3*(mesh.mua+mesh.mus));
end

% Create FEM matricex
if mesh.dimension == 2
    [i,j,s] = gen_matrices_2d(mesh.nodes(:,1:2),...
        sort(mesh.elements,2), ...
        mesh.bndvtx,...
        mesh.mua,...
        mesh.kappa,...
        mesh.ksi,...
        mesh.c,...
        omega);
elseif mesh.dimension ==3
    [i,j,s] = gen_matrices_3d(mesh.nodes,...
        sort(mesh.elements,2), ...
        mesh.bndvtx,...
        mesh.mua,...
        mesh.kappa,...
        mesh.ksi,...
        mesh.c,...
        omega);
end

junk = length(find(i==0));
MASS = sparse(i(1:end-junk),j(1:end-junk),s(1:end-junk));
clear junk i j s omega
% If the fn.ident exists, then we must modify the FEM matrices to
% account for refractive index mismatch within internal boundaries
if isfield(mesh,'ident') == 1
    M = bound_int(MASS,mesh);
    MASS = M;
    clear M
end

end

