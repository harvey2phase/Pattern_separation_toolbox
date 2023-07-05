start_pattern_separation;

compute_mi = false;
compute_te = true;

eps = 10^-2;
e1s = [0.10, 0.20, 0.30, 0.40, 0.50];

p11_start_index = 1;
n_p11s = 10;
trial_start_index = 1;
n_trials = 10;

data_folder_name = "spiketimes/variable-th/t=16-n_bins=1e3";

if compute_mi
    mi_folder = "results/mi/";
    rr_folder = "results/rr/";
end
if compute_te
    te_folder = "results/te/";
end

for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p11s = linspace(eps, e1s(i)-eps, n_p11s);

    if compute_mi
        mi_results = cell(n_p11s, n_trials);
        rr_results = cell(n_p11s, n_trials);
    end
    if compute_te
        te_results = cell(n_p11s, n_trials);
    end

    for j=p11_start_index:n_p11s
        
        p11_folder = e1_folder + "/" + "p11=" + compose("%0.2f", p11s(j));
        disp(p11_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p11_folder + "/out_times" + string(k) + ".csv";

            in_times = read_spiketimes(infile_name);
            out_times = read_spiketimes(outfile_name);

            if compute_mi
                patsep = analyse_pattern_separation(in_times,out_times,'estimate',true);
                mi_results{j, k} = patsep.info_details.MI;
                rr_results{j, k} = patsep.info_details.RR;
                fprintf("(%f, %f); ", patsep.info_details.MI, patsep.info_details.RR);
            end
            if compute_te
                num_params = struct;
                TEoptions = '-max_bins -max_code -par';
                TE_obj = TE_function(in_times,out_times,[],num_params,TEoptions);
                te_results{j, k} = TE_obj.TE;
            end
        end

        disp("writing...");
        
        e1_results_folder = "e1=" + string(e1s(i)) + ".csv";
        if compute_mi
            csvwrite(mi_folder + e1_results_folder, mi_results);
            csvwrite(rr_folder + e1_results_folder, rr_results);
        end
        if compute_te
            csvwrite(te_folder + e1_folder, te_results);
        end
    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end