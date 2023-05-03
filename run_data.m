start_pattern_separation

n_p110s = 10;
n_trials = 10;
eps = 10^-2;
e1s = [0.3, 0.4, 0.5];

p110_start_index = 1;
trial_start_index = 1;

data_folder_name = "spiketimes";
results_folder_name = "results/te/";

for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p110s = linspace(eps, e1s(i)-eps, n_p110s);
    results = cell(n_p110s, n_trials);

    for j=p110_start_index:n_p110s
        
        p110_folder = e1_folder + "/" + "p11=" + compose("%0.2f", p110s(j));
        disp(p110_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p110_folder + "/out_times" + string(k) + ".csv";

            in_spiketimes = read_spiketimes(infile_name);
            out_spiketimes = read_spiketimes(outfile_name);

            num_params=struct;
            TEoptions='-max_bins -max_code -par';
            TE_obj=TE_function(in_spiketimes,out_spiketimes,[],num_params,TEoptions);
            result=TE_obj.TE;

            fprintf("%f, ", result);
            results{j, k} = result;
        end
        disp("writing...");
        csvwrite(results_folder_name + "e1=" + string(e1s(i)) + ".csv", results);
    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end