start_pattern_separation;

eps = 10^-2;
e1s = [0.10, 0.20, 0.30, 0.40, 0.50];

p11_start_index = 1;
n_p11s = 10;
trial_start_index = 1;
n_trials = 10;

data_folder_name = "spiketimes";
mi_folder = "results/mi/";
rr_folder = "results/rr/";
te_folder = "results/te/";
sp_mi_folder = "results/sp_mi/";
sp_rr_folder = "results/sp_rr/";
sp_te_folder = "results/sp_te/";


for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p11s = linspace(eps, e1s(i)-eps, n_p11s);

    mi_results = cell(n_p11s, n_trials);
    rr_results = cell(n_p11s, n_trials);
    te_results = cell(n_p11s, n_trials);
    sp_mi_results = cell(n_p11s, n_trials);
    sp_rr_results = cell(n_p11s, n_trials);
    sp_te_results = cell(n_p11s, n_trials);

    for j=p11_start_index:n_p11s
        
        p11_folder = e1_folder + "/" + "p11=" + compose("%0.2f", p11s(j));
        disp(p11_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p11_folder + "/out_times" + string(k) + ".csv";

            in_times = read_spiketimes(infile_name);
            out_times = read_spiketimes(outfile_name);

            patsep=analyse_pattern_separation(in_times,out_times);

            fprintf("%f, ", patsep.info_details.input_code);

            mi_results{j, k} = patsep.info_details.MI;
            rr_results{j, k} = patsep.info_details.RR;
            te_results{j, k} = patsep.info_details.TE;
            sp_mi_results{j, k} = patsep.info_details.spMI;
            sp_rr_results{j, k} = patsep.info_details.spRR;
            sp_te_results{j, k} = patsep.info_details.spTE;
        end

        disp("writing...");
        e1_folder = "e1=" + string(e1s(i)) + ".csv";

        csvwrite(mi_folder + e1_folder, mi_results);
        csvwrite(rr_folder + e1_folder, rr_results);
        csvwrite(te_folder + e1_folder, te_results);
        csvwrite(sp_mi_folder + e1_folder, sp_mi_results);
        csvwrite(sp_rr_folder + e1_folder, sp_rr_results);
        csvwrite(sp_te_folder + e1_folder, sp_te_results);

    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end