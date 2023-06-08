start_pattern_separation;

eps = 10^-2;
e1s = [0.10, 0.20, 0.30, 0.40, 0.50];

p110_start_index = 1;
n_p11s = 10;
trial_start_index = 1;
n_trials = 10;

data_folder_name = "spiketimes";
results_folder = "results/mi/";

for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p11s = linspace(eps, e1s(i)-eps, n_p11s);
    results = cell(n_p11s, n_trials);

    for j=p110_start_index:n_p11s
        
        p110_folder = e1_folder + "/" + "p11=" + compose("%0.2f", p11s(j));
        disp(p110_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p110_folder + "/out_times" + string(k) + ".csv";

            input_spiketimes = read_spiketimes(infile_name);
            output_spiketimes = read_spiketimes(outfile_name);

            estMI_obj = estimate_MI(input_spiketimes,output_spiketimes,'-par');

            fprintf("%f, ", estMI_obj.RR);

            results{j, k} = estMI_obj.RR;
        end

        disp("writing...");
        e1_results_folder = results_folder + "e1=" + string(e1s(i)) + ".csv";
        disp(e1_results_folder);
        csvwrite(e1_results_folder, results);
    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end