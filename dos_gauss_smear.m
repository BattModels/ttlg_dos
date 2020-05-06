% calculate the momentum space local density of states using gaussian smearing
function [dos] = dos_gauss_smear(H, tar_dofs, param, E_list, num_eig, sigma)
    % input: Hamiltonian H at a momentum q, tar_dofs: indices that
    % correspond to the origin in the k degree of freedom
    % param: parameters for the Gaussian functions 
    
    % first diagonalize the Hamiltonian to obtain a list of evals and evecs
    if num_eig ~= length(H)
        [raw_vecs, raw_vals] = eigs(H,num_eig,sigma);
    else 
        
        [raw_vecs, raw_vals] = eig(full(H));
    end 
    [vals, order] = sort(real(diag(raw_vals)));
    
    % magnitude of zero evals for each layer 
    for tar_sheet = 1:3
        weights(tar_sheet,:) = sum(abs(raw_vecs(tar_dofs(tar_sheet,:),order)).^2,1);
    end 
    
    % en_all = linspace(min(raw_vals), max(raw_vals), floor(max(raw_vals)-min(raw_vals)/res));
    dos = zeros(size(E_list));
    % make gaussians & calculate dof 
    for e_idx = 1:length(vals)
        gauss_here = param / (2*pi^3) * exp(-((vals(e_idx)-E_list)*param).^2./pi^2);
        for l_idx = 1:3 
            dos = dos + squeeze(gauss_here*weights(l_idx,e_idx));
        end 
    end 
    
    