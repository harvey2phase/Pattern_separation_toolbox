start_pattern_separation;

compute_mi = false;
compute_te = true;

n_e2s = 10;
min_e2 = 0.1;
max_e2 = 0.9;
e2s = linspace(min_e2, max_e2, n_e2s);

trial_start_index = 1;
n_trials = 10;

data_folder_name = "spiketimes/variable-e2/e1=0.30";

if compute_mi
    mi_folder = "results/mi/";
    rr_folder = "results/rr/";
end
if compute_te
    te_folder = "results/te/";
end

if compute_mi
    mi_results = cell(n_trials);
    rr_results = cell(n_trials);
end
if compute_te
    te_results = cell(n_trials);
end

for j=1:n_e2s
        
    e2_folder = data_folder_name + "/" + "e2=" + compose("%0.2f", e2s(j));
    disp(e2_folder);

    for k=trial_start_index:n_trials
        infile_name = data_folder_name + "/in_times" + string(k) + ".csv";
        outfile_name = e2_folder + "/out_times" + string(k) + ".csv";
        %disp(infile_name);
        %disp(outfile_name);

        in_times = read_spiketimes(infile_name);
        out_times = read_spiketimes(outfile_name);

        if compute_mi
            patsep = analyse_pattern_separation(in_times,out_times, 'estimate', true);

            mi_results{j, k} = patsep.info_details.MI;
            rr_results{j, k} = patsep.info_details.RR;
            fprintf("(%f, %f); ", patsep.info_details.MI, patsep.info_details.RR);
        end
        
        if compute_te
            num_params = struct;
            TEoptions = '-max_bins -max_code -par';
            TE_obj = TE_function(in_times, out_times, [], num_params, TEoptions);
            te_results{j, k} = TE_obj.TE;
            fprintf("%f, ", TE_obj.TE);
        end
        
    end

    disp("writing...");
    e2_results_folder = "variable-e2-e1=0.3.csv";

    if compute_mi
        csvwrite(mi_folder + e2_results_folder, mi_results);
        csvwrite(rr_folder + e2_results_folder, rr_results);
    end
    if compute_te
        csvwrite(te_folder + e1_folder, te_results);
    end

end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end