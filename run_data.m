start_pattern_separation;

n_p11s = 10;
n_trials = 10;
eps = 10^-2;
e1s = [0.10, 0.20, 0.30, 0.40, 0.50];

p110_start_index = 1;
trial_start_index = 1;

data_folder_name = "spiketimes";
rr_folder = "results/rr/";

for i = 1:length(e1s)
    e1_folder = data_folder_name + "/e1=" + compose("%0.2f", e1s(i));
    p110s = linspace(eps, e1s(i)-eps, n_p11s);
    rr_results = cell(n_p11s, n_trials);

    for j=p110_start_index:n_p11s
        
        p110_folder = e1_folder + "/" + "p11=" + compose("%0.2f", p110s(j));
        disp(p110_folder);

        for k=trial_start_index:n_trials
            infile_name = e1_folder + "/in_times" + string(k) + ".csv";
            outfile_name = p110_folder + "/out_times" + string(k) + ".csv";

            input_spiketimes = read_spiketimes(infile_name);
            output_spiketimes = read_spiketimes(outfile_name);

            estRR_obj = estimate_RR(input_spiketimes,output_spiketimes,'-par');

            fprintf("%f, ", estRR_obj.RR);

            rr_results{j, k} = estRR_obj.RR;
        end
        disp("writing...");
        rr_e1_folder = rr_folder + "e1=" + string(e1s(i)) + ".csv";
        disp(rr_e1_folder);
        csvwrite(rr_e1_folder, rr_results);
    end
end

    


function spiketimes = read_spiketimes(filename)
    spiketimes = cell(2, 1);
    
    file = csvread(filename);

    spiketimes{1} = permute(nonzeros(file(1,:)), [2 1]);
    spiketimes{2} = permute(nonzeros(file(2,:)), [2 1]);
end