start_pattern_separation

n_p110s = 10;
n_trials = 10;

p110_start_index = 1;
trial_start_index = 1;

e1s = [0.1, 0.2, 0.3, 0.4, 0.5];

results = cell(length(e1s) * n_p110s, n_trials);

data_folder_name = "spiketimes";
for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p110s = linspace(0, e1s(i), n_p110s);

    disp(e1_folder);

    for j=p110_start_index:n_p110s
        p110_folder = e1_folder + "/" + "p110=" + compose("%0.2f", p110s(j));
        disp(p110_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p110_folder + "/out_times" + string(k) + ".csv";

            in_spiketimes = read_spiketimes(infile_name);
            out_spiketimes = read_spiketimes(outfile_name);

            dist_obj = distance(in_spiketimes,out_spiketimes);
            result = dist_obj.dist_est;
            disp(result);
            results{(i - 1) * n_p110s + j, k} = result;
        end
        disp("writing...");
        csvwrite("wass_results_e1=" + string(e1s(i)) + ".csv", results);
    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end