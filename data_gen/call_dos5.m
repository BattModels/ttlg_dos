% author: ziyan (zoe) zhu
% email: zzhu1@g.harvard.edu
% example calculatiion of the DOS
clear all
addpath('..')

q2_list=[2.6]
q1_list=[4.6]
%q2_list = [2.2, 2.3, 2.4, 2.5, 2.6];
%q1_list = [4.9, 5.0];
k_cutoff = 5;                     % k space cutoff in the unit of reciprocal lattice constant   
E_list = linspace(-1,1,1e3);  % list of energies in eV
q_cut_type = 1;                   % type of Brillouin zone sampling. 
                                  % type 1: monolayer Brillouin zone
                                  % type 2: L12 moire Brillouin zone
                                  % type 3: L23 moire Brillouin zone
num_eigs = 1000;                    % number of eigenvalues to keep in the diagonalization
nq = 31;                          % grid size
E_field = 0;                      % vertical displacement field 
save_data = 1; 
a0 = 1.43 * sqrt(3);

% parallelization; define the number of parallel processes
% if running on a cluster 
% np = str2num(getenv('SLURM_CPUS_PER_TASK')); % number of workers

% if running locally 
np = 56;

k = 1;
for i = 1:length(q1_list)
    for j = 1:length(q2_list)
        twist(:, k) = [q1_list(i), q2_list(j)];
        k = k + 1;
    end 
end 

% total number of twist angles to calculate
tot_pt = length(q1_list)*length(q2_list); 

parpool('local',np)
%figure(234)
%set(gcf,'Position',[211 101 453 453])
% clf
for i = 1:tot_pt
    %if exist('np','var')
    %    parpool('local',np)
    %else 
    %    parpool('local',1)
    %end 
    
    param = 6e-3;
    lg{i} = ['$\theta_{12} = ' num2str(twist(1,i)) '^\circ$' 10 '$\theta_{23} = ' ...
        num2str(twist(2,i)) '^\circ$'];
    fprintf("Running twist angle %d/%d \n", i, tot_pt)
    tic
    [dos_tot, dos_tot_mono, dos_fit, prefac] = dos_calc_tri(a0,twist(1,i),twist(2,i),E_field,k_cutoff,param,nq,num_eigs,E_list,q_cut_type,save_data);
    toc
    
    % check monolayer fit 
    %subplot(1,2,1)
    %box on
    %hold all; 
    %plot(dos_tot_mono, E_list, 'LineWidth', 2)
    %plot(prefac*polyval(dos_fit,E_list),E_list,'k--','LineWidth',2)
    %ylim([-0.8 0.8])
    %xlim([0 max(dos_tot_mono(:))*1.1]);
    %title('Monolayer')
    %ylabel('Energy (eV)')
    %xlabel('DoS $\mathrm{(eV^{-1}\cdot\AA^{-2})}$','Interpreter','latex');

    %subplot(1,2,2)
    %box on;
    %hold all
    %plot(dos_tot,E_list, 'LineWidth', 2)
    %ylim([-0.8 0.8])
    %yticklabels([])
    %legend(lg,'Interpreter','latex')
    %title('Full DOS')
    %xlabel('DoS $\mathrm{(eV^{-1}\cdot\AA^{-2})}$','Interpreter','latex');

    
    disp("=====================================")
    %delete(gcp('nocreate'))
end 

delete(gcp('nocreate'))


