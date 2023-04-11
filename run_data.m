start_pattern_separation

n_p110s = 10;
n_trials = 10;
eps = 10^-2;
e1s = [0.1, 0.2, 0.3, 0.4, 0.5];

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



function [input_spiketimes, output_spiketimes] = get_test_data()
    input_spiketimes = cell(2, 1);
    input_spiketimes{1} = [0.016016016016016016,0.03203203203203203,0.06406406406406406,0.11211211211211211,0.14414414414414414,0.24024024024024024,0.27227227227227224,0.2882882882882883,0.3363363363363363,0.3683683683683684,0.3843843843843844,0.46446446446446443,0.5125125125125125,0.5445445445445445,0.5605605605605606,0.5765765765765766,0.5925925925925926,0.6246246246246246,0.6406406406406406,0.6886886886886887,0.7047047047047047,0.7367367367367368,0.7527527527527528,0.7847847847847848,0.8328328328328328,0.8488488488488488,0.8648648648648649,0.8808808808808809,0.8968968968968969,0.9129129129129129,0.960960960960961,1.057057057057057,1.073073073073073,1.105105105105105,1.1211211211211212,1.1691691691691692,1.2332332332332332,1.2972972972972974,1.3293293293293293,1.4894894894894894,1.5055055055055055,1.5375375375375375,1.6496496496496496,1.6656656656656657,1.6976976976976976,1.7297297297297298,1.7457457457457457,1.7937937937937938,1.8098098098098099,1.8258258258258258,1.8738738738738738,1.88988988988989,1.921921921921922,2.002002002002002,2.018018018018018,2.05005005005005,2.0820820820820822,2.098098098098098,2.114114114114114,2.146146146146146,2.274274274274274,2.29029029029029,2.3063063063063063,2.3223223223223224,2.354354354354354,2.3703703703703702,2.3863863863863863,2.4184184184184185,2.4504504504504503,2.4984984984984986,2.6106106106106104,2.6266266266266265,2.6426426426426426,2.8028028028028027,2.818818818818819,2.850850850850851,2.962962962962963,2.994994994994995,3.027027027027027,3.1071071071071072,3.139139139139139,3.219219219219219,3.2512512512512513,3.2672672672672673,3.2832832832832834,3.3313313313313313,3.3473473473473474,3.3633633633633635,3.4914914914914914,3.5075075075075075,3.5555555555555554,3.5875875875875876,3.6836836836836837,3.7317317317317316,3.8118118118118116,3.843843843843844,3.875875875875876,3.9079079079079078,4.02002002002002,4.036036036036036,4.116116116116116,4.148148148148148,4.1641641641641645,4.18018018018018,4.2442442442442445,4.26026026026026,4.34034034034034,4.356356356356356,4.372372372372372,4.388388388388388,4.436436436436437,4.484484484484485,4.5005005005005,4.5325325325325325,4.58058058058058,4.596596596596597,4.612612612612613,4.692692692692693,4.708708708708708,4.756756756756757,4.772772772772773,4.788788788788788,4.8208208208208205,4.964964964964965,4.996996996996997,5.109109109109109,5.141141141141141,5.1891891891891895,5.205205205205205,5.253253253253253,5.285285285285285,5.317317317317317,5.333333333333333,5.34934934934935,5.365365365365365,5.397397397397397,5.413413413413413,5.42942942942943,5.4774774774774775,5.541541541541542,5.621621621621622,5.653653653653653,5.66966966966967,5.685685685685685,5.74974974974975,5.797797797797798,5.861861861861862,5.877877877877878,5.893893893893894,5.957957957957958,6.07007007007007,6.086086086086086,6.134134134134134,6.15015015015015,6.166166166166166,6.182182182182182,6.198198198198198,6.23023023023023,6.278278278278278,6.31031031031031,6.326326326326326,6.438438438438438,6.55055055055055,6.5825825825825826,6.598598598598598,6.614614614614615,6.662662662662663,6.678678678678678,6.694694694694695,6.7107107107107105,6.726726726726727,6.774774774774775,6.7907907907907905,6.870870870870871,6.950950950950951,6.982982982982983,6.998998998998999,7.095095095095095,7.143143143143143,7.191191191191191,7.287287287287287,7.351351351351351,7.463463463463463,7.47947947947948,7.543543543543543,7.55955955955956,7.591591591591592,7.607607607607608,7.623623623623623,7.671671671671672,7.703703703703703,7.767767767767768,7.7997997997998,7.8158158158158155,7.831831831831832,7.863863863863863,7.87987987987988,7.911911911911912,7.927927927927928,7.943943943943944,7.991991991991992,8.04004004004004,8.088088088088089,8.12012012012012,8.136136136136136,8.216216216216216,8.248248248248249,8.28028028028028,8.328328328328329,8.36036036036036,8.472472472472472,8.504504504504505,8.552552552552552,8.568568568568569,8.584584584584585,8.616616616616616,8.64864864864865,8.664664664664665,8.68068068068068,8.712712712712712,8.744744744744745,8.776776776776776,8.792792792792794,8.856856856856856,8.88888888888889,8.936936936936936,8.984984984984985,9.033033033033034,9.065065065065065,9.097097097097096,9.113113113113114,9.16116116116116,9.193193193193194,9.24124124124124,9.257257257257256,9.32132132132132,9.36936936936937,9.401401401401401,9.417417417417417,9.465465465465465,9.481481481481481,9.497497497497497,9.657657657657657,9.673673673673674,9.68968968968969,9.737737737737739,9.913913913913914,9.92992992992993,9.977977977977979,10.026026026026026,10.058058058058059,10.122122122122121,10.154154154154154,10.17017017017017,10.186186186186186,10.202202202202201,10.234234234234235,10.25025025025025,10.298298298298299,10.314314314314315,10.346346346346346,10.362362362362362,10.426426426426426,10.49049049049049,10.522522522522522,10.602602602602602,10.634634634634635,10.65065065065065,10.666666666666666,10.682682682682682,10.6986986986987,10.73073073073073,10.746746746746746,10.77877877877878,10.826826826826826,10.842842842842844,10.874874874874875,10.93893893893894,10.954954954954955,10.97097097097097,11.003003003003004,11.035035035035035,11.083083083083084,11.115115115115115,11.17917917917918,11.21121121121121,11.243243243243244,11.355355355355355,11.37137137137137,11.403403403403404,11.467467467467467,11.483483483483484,11.4994994994995,11.57957957957958,11.595595595595595,11.627627627627627,11.65965965965966,11.691691691691691,11.723723723723724,11.73973973973974,11.803803803803804,11.867867867867869,11.883883883883884,11.8998998998999,11.947947947947949,11.963963963963964,11.97997997997998,12.044044044044044,12.076076076076076,12.092092092092091,12.252252252252251,12.316316316316316,12.348348348348349,12.364364364364365,12.396396396396396,12.476476476476476,12.524524524524525,12.54054054054054,12.572572572572572,12.604604604604605,12.62062062062062,12.636636636636636,12.652652652652652,12.684684684684685,12.7007007007007,12.716716716716716,12.812812812812812,12.876876876876876,12.90890890890891,12.94094094094094,12.956956956956956,12.98898898898899,13.037037037037036,13.06906906906907,13.165165165165165,13.213213213213214,13.22922922922923,13.30930930930931,13.325325325325325,13.38938938938939,13.405405405405405,13.453453453453454,13.485485485485485,13.54954954954955,13.565565565565565,13.581581581581581,13.62962962962963,13.645645645645645,13.693693693693694,13.70970970970971,13.725725725725725,13.773773773773774,13.821821821821821,13.86986986986987,13.94994994994995,13.965965965965966,13.981981981981981,14.046046046046046,14.078078078078079,14.11011011011011,14.126126126126126,14.142142142142141,14.222222222222221,14.254254254254255,14.27027027027027,14.286286286286286,14.382382382382382,14.414414414414415,14.622622622622622,14.71871871871872,14.734734734734735,14.766766766766766,14.83083083083083,14.862862862862862,14.894894894894895,15.023023023023024,15.03903903903904,15.055055055055055,15.167167167167166,15.183183183183184,15.27927927927928,15.327327327327327,15.343343343343344,15.375375375375375,15.43943943943944,15.455455455455455,15.503503503503504,15.51951951951952,15.551551551551551,15.567567567567567,15.663663663663664,15.711711711711711,15.727727727727727,15.791791791791791,15.871871871871871];
    input_spiketimes{2} = [0.0,0.04804804804804805,0.08008008008008008,0.0960960960960961,0.12812812812812813,0.16016016016016016,0.17617617617617617,0.1921921921921922,0.2082082082082082,0.22422422422422422,0.25625625625625625,0.30430430430430433,0.3203203203203203,0.35235235235235235,0.40040040040040037,0.4164164164164164,0.43243243243243246,0.44844844844844844,0.4804804804804805,0.4964964964964965,0.5285285285285285,0.6086086086086087,0.6566566566566566,0.6726726726726726,0.7207207207207207,0.7687687687687688,0.8008008008008007,0.8168168168168168,0.9289289289289289,0.944944944944945,0.9769769769769769,0.992992992992993,1.009009009009009,1.025025025025025,1.0410410410410411,1.089089089089089,1.137137137137137,1.1531531531531531,1.1851851851851851,1.2012012012012012,1.2172172172172173,1.2492492492492493,1.2652652652652652,1.2812812812812813,1.3133133133133132,1.3453453453453452,1.3613613613613613,1.3773773773773774,1.3933933933933933,1.4094094094094094,1.4254254254254255,1.4414414414414414,1.4574574574574575,1.4734734734734736,1.5215215215215214,1.5535535535535536,1.5695695695695695,1.5855855855855856,1.6016016016016015,1.6176176176176176,1.6336336336336337,1.6816816816816818,1.7137137137137137,1.7617617617617618,1.7777777777777777,1.8418418418418419,1.8578578578578577,1.9059059059059058,1.937937937937938,1.9539539539539539,1.96996996996997,1.985985985985986,2.034034034034034,2.066066066066066,2.13013013013013,2.1621621621621623,2.178178178178178,2.194194194194194,2.21021021021021,2.2262262262262262,2.2422422422422423,2.2582582582582584,2.3383383383383385,2.4024024024024024,2.4344344344344346,2.4664664664664664,2.4824824824824825,2.5145145145145147,2.5305305305305303,2.5465465465465464,2.5625625625625625,2.5785785785785786,2.5945945945945947,2.6586586586586587,2.674674674674675,2.6906906906906904,2.7067067067067065,2.7227227227227226,2.7387387387387387,2.754754754754755,2.770770770770771,2.7867867867867866,2.834834834834835,2.8668668668668666,2.8828828828828827,2.898898898898899,2.914914914914915,2.930930930930931,2.946946946946947,2.978978978978979,3.011011011011011,3.043043043043043,3.059059059059059,3.075075075075075,3.091091091091091,3.123123123123123,3.155155155155155,3.171171171171171,3.1871871871871873,3.203203203203203,3.235235235235235,3.299299299299299,3.315315315315315,3.379379379379379,3.3953953953953953,3.4114114114114114,3.4274274274274275,3.4434434434434436,3.4594594594594597,3.4754754754754753,3.5235235235235236,3.5395395395395397,3.5715715715715715,3.6036036036036037,3.6196196196196198,3.6356356356356354,3.6516516516516515,3.6676676676676676,3.6996996996997,3.7157157157157155,3.7477477477477477,3.7637637637637638,3.77977977977978,3.795795795795796,3.8278278278278277,3.85985985985986,3.8918918918918917,3.923923923923924,3.93993993993994,3.955955955955956,3.971971971971972,3.987987987987988,4.004004004004004,4.052052052052052,4.068068068068068,4.084084084084084,4.1001001001001,4.132132132132132,4.196196196196196,4.212212212212212,4.228228228228228,4.276276276276276,4.292292292292292,4.308308308308308,4.324324324324325,4.404404404404405,4.42042042042042,4.4524524524524525,4.468468468468468,4.516516516516517,4.548548548548548,4.564564564564565,4.628628628628628,4.644644644644645,4.66066066066066,4.676676676676677,4.724724724724725,4.7407407407407405,4.804804804804805,4.836836836836837,4.852852852852853,4.868868868868869,4.884884884884885,4.900900900900901,4.916916916916917,4.932932932932933,4.948948948948949,4.980980980980981,5.013013013013013,5.029029029029029,5.045045045045045,5.061061061061061,5.077077077077077,5.093093093093093,5.125125125125125,5.157157157157157,5.173173173173173,5.221221221221221,5.237237237237237,5.2692692692692695,5.301301301301301,5.381381381381381,5.445445445445445,5.461461461461462,5.493493493493493,5.50950950950951,5.525525525525525,5.5575575575575575,5.573573573573573,5.58958958958959,5.605605605605605,5.637637637637638,5.701701701701702,5.717717717717718,5.733733733733733,5.7657657657657655,5.781781781781782,5.813813813813813,5.82982982982983,5.8458458458458455,5.90990990990991,5.925925925925926,5.941941941941942,5.973973973973974,5.98998998998999,6.006006006006006,6.022022022022022,6.038038038038038,6.054054054054054,6.102102102102102,6.118118118118118,6.2142142142142145,6.246246246246246,6.262262262262262,6.2942942942942945,6.342342342342342,6.358358358358358,6.374374374374375,6.39039039039039,6.406406406406406,6.4224224224224224,6.454454454454455,6.47047047047047,6.486486486486487,6.5025025025025025,6.518518518518518,6.534534534534535,6.566566566566567,6.63063063063063,6.646646646646647,6.742742742742743,6.758758758758758,6.806806806806807,6.822822822822823,6.838838838838838,6.854854854854855,6.886886886886887,6.902902902902903,6.918918918918919,6.934934934934935,6.966966966966967,7.015015015015015,7.031031031031031,7.047047047047047,7.063063063063063,7.079079079079079,7.111111111111111,7.127127127127127,7.1591591591591595,7.175175175175175,7.207207207207207,7.223223223223223,7.2392392392392395,7.255255255255255,7.271271271271271,7.303303303303303,7.31931931931932,7.335335335335335,7.367367367367367,7.383383383383383,7.3993993993994,7.415415415415415,7.431431431431431,7.4474474474474475,7.495495495495495,7.511511511511512,7.5275275275275275,7.575575575575575,7.63963963963964,7.655655655655655,7.687687687687688,7.71971971971972,7.7357357357357355,7.751751751751752,7.783783783783783,7.847847847847848,7.895895895895896,7.95995995995996,7.975975975975976,8.008008008008009,8.024024024024024,8.056056056056056,8.072072072072071,8.104104104104104,8.152152152152151,8.168168168168169,8.184184184184184,8.2002002002002,8.232232232232231,8.264264264264265,8.296296296296296,8.312312312312311,8.344344344344345,8.376376376376376,8.392392392392392,8.408408408408409,8.424424424424425,8.44044044044044,8.456456456456456,8.488488488488489,8.52052052052052,8.536536536536536,8.6006006006006,8.632632632632632,8.696696696696696,8.72872872872873,8.76076076076076,8.80880880880881,8.824824824824825,8.84084084084084,8.872872872872874,8.904904904904905,8.92092092092092,8.952952952952954,8.96896896896897,9.001001001001,9.017017017017016,9.04904904904905,9.08108108108108,9.12912912912913,9.145145145145145,9.177177177177176,9.20920920920921,9.225225225225225,9.273273273273274,9.28928928928929,9.305305305305305,9.337337337337337,9.353353353353354,9.385385385385385,9.433433433433434,9.44944944944945,9.513513513513514,9.52952952952953,9.545545545545545,9.561561561561561,9.577577577577577,9.593593593593594,9.60960960960961,9.625625625625625,9.641641641641641,9.705705705705705,9.721721721721721,9.753753753753754,9.76976976976977,9.785785785785786,9.801801801801801,9.817817817817819,9.833833833833834,9.84984984984985,9.865865865865866,9.881881881881881,9.897897897897899,9.945945945945946,9.961961961961961,9.993993993993994,10.01001001001001,10.042042042042041,10.074074074074074,10.09009009009009,10.106106106106106,10.138138138138139,10.218218218218219,10.266266266266266,10.282282282282281,10.33033033033033,10.378378378378379,10.394394394394395,10.41041041041041,10.442442442442442,10.458458458458459,10.474474474474475,10.506506506506506,10.538538538538539,10.554554554554555,10.57057057057057,10.586586586586586,10.618618618618619,10.714714714714715,10.762762762762762,10.794794794794795,10.81081081081081,10.85885885885886,10.89089089089089,10.906906906906906,10.922922922922924,10.986986986986986,11.01901901901902,11.05105105105105,11.067067067067066,11.0990990990991,11.13113113113113,11.147147147147146,11.163163163163164,11.195195195195195,11.227227227227226,11.25925925925926,11.275275275275275,11.29129129129129,11.307307307307306,11.323323323323324,11.33933933933934,11.387387387387387,11.41941941941942,11.435435435435435,11.451451451451451,11.515515515515515,11.531531531531531,11.547547547547547,11.563563563563564,11.611611611611611,11.643643643643644,11.675675675675675,11.707707707707707,11.755755755755755,11.771771771771771,11.787787787787789,11.81981981981982,11.835835835835836,11.851851851851851,11.915915915915916,11.931931931931931,11.995995995995996,12.012012012012011,12.028028028028029,12.06006006006006,12.108108108108109,12.124124124124124,12.14014014014014,12.156156156156156,12.172172172172171,12.188188188188189,12.204204204204204,12.22022022022022,12.236236236236236,12.268268268268269,12.284284284284285,12.3003003003003,12.332332332332332,12.38038038038038,12.412412412412412,12.428428428428429,12.444444444444445,12.46046046046046,12.492492492492492,12.508508508508509,12.556556556556556,12.588588588588589,12.66866866866867,12.732732732732732,12.74874874874875,12.764764764764765,12.78078078078078,12.796796796796796,12.82882882882883,12.844844844844845,12.86086086086086,12.892892892892894,12.924924924924925,12.972972972972974,13.005005005005005,13.02102102102102,13.053053053053054,13.085085085085085,13.1011011011011,13.117117117117116,13.133133133133134,13.14914914914915,13.18118118118118,13.197197197197196,13.245245245245245,13.26126126126126,13.277277277277276,13.293293293293294,13.34134134134134,13.357357357357357,13.373373373373374,13.421421421421421,13.437437437437437,13.46946946946947,13.501501501501501,13.517517517517517,13.533533533533534,13.597597597597597,13.613613613613614,13.661661661661661,13.677677677677677,13.741741741741741,13.757757757757757,13.78978978978979,13.805805805805806,13.837837837837839,13.853853853853854,13.885885885885886,13.901901901901901,13.917917917917919,13.933933933933934,13.997997997997999,14.014014014014014,14.03003003003003,14.062062062062061,14.094094094094094,14.158158158158159,14.174174174174174,14.19019019019019,14.206206206206206,14.238238238238239,14.302302302302301,14.318318318318319,14.334334334334335,14.35035035035035,14.366366366366366,14.398398398398399,14.43043043043043,14.446446446446446,14.462462462462462,14.478478478478479,14.494494494494495,14.51051051051051,14.526526526526526,14.542542542542542,14.558558558558559,14.574574574574575,14.59059059059059,14.606606606606606,14.63863863863864,14.654654654654655,14.67067067067067,14.686686686686686,14.702702702702702,14.75075075075075,14.782782782782782,14.7987987987988,14.814814814814815,14.846846846846846,14.87887887887888,14.91091091091091,14.926926926926926,14.942942942942944,14.95895895895896,14.974974974974975,14.99099099099099,15.007007007007006,15.07107107107107,15.087087087087086,15.103103103103104,15.11911911911912,15.135135135135135,15.15115115115115,15.1991991991992,15.215215215215215,15.23123123123123,15.247247247247246,15.263263263263264,15.295295295295295,15.31131131131131,15.35935935935936,15.391391391391391,15.407407407407407,15.423423423423424,15.471471471471471,15.487487487487487,15.535535535535535,15.583583583583584,15.5995995995996,15.615615615615615,15.631631631631631,15.647647647647647,15.67967967967968,15.695695695695695,15.743743743743744,15.75975975975976,15.775775775775776,15.807807807807807,15.823823823823824,15.83983983983984,15.855855855855856,15.887887887887889,15.903903903903904,15.91991991991992,15.935935935935936,15.951951951951951,15.967967967967969,15.983983983983984,16.0];
    
    output_spiketimes = cell(2, 1);
    output_spiketimes{1, 1} = [0.016016016016016016,0.03203203203203203,0.04804804804804805,0.08008008008008008,0.12812812812812813,0.22422422422422422,0.2882882882882883,0.30430430430430433,0.3363363363363363,0.40040040040040037,0.4964964964964965,0.5125125125125125,0.5605605605605606,0.5765765765765766,0.6086086086086087,0.6566566566566566,0.6726726726726726,0.7207207207207207,0.7367367367367368,0.7687687687687688,0.8488488488488488,0.8648648648648649,0.9129129129129129,0.944944944944945,0.960960960960961,0.992992992992993,1.0410410410410411,1.105105105105105,1.1211211211211212,1.2012012012012012,1.3133133133133132,1.3453453453453452,1.3613613613613613,1.4254254254254255,1.4574574574574575,1.4734734734734736,1.4894894894894894,1.5055055055055055,1.5215215215215214,1.5855855855855856,1.6176176176176176,1.6336336336336337,1.6496496496496496,1.6656656656656657,1.6976976976976976,1.7137137137137137,1.7457457457457457,1.7777777777777777,1.8098098098098099,1.8418418418418419,1.9059059059059058,1.921921921921922,1.937937937937938,2.002002002002002,2.05005005005005,2.066066066066066,2.146146146146146,2.178178178178178,2.21021021021021,2.2422422422422423,2.29029029029029,2.3703703703703702,2.3863863863863863,2.4664664664664664,2.4824824824824825,2.4984984984984986,2.5145145145145147,2.5465465465465464,2.674674674674675,2.6906906906906904,2.7067067067067065,2.7227227227227226,2.7867867867867866,2.8028028028028027,2.850850850850851,2.8668668668668666,2.930930930930931,2.962962962962963,3.027027027027027,3.043043043043043,3.059059059059059,3.075075075075075,3.1071071071071072,3.155155155155155,3.171171171171171,3.1871871871871873,3.2512512512512513,3.4114114114114114,3.4274274274274275,3.4754754754754753,3.5555555555555554,3.5715715715715715,3.6036036036036037,3.6516516516516515,3.6836836836836837,3.7157157157157155,3.7317317317317316,3.7477477477477477,3.7637637637637638,3.77977977977978,3.8118118118118116,3.8278278278278277,3.843843843843844,3.923923923923924,3.971971971971972,3.987987987987988,4.052052052052052,4.084084084084084,4.18018018018018,4.196196196196196,4.2442442442442445,4.276276276276276,4.468468468468468,4.484484484484485,4.564564564564565,4.596596596596597,4.644644644644645,4.756756756756757,4.804804804804805,4.868868868868869,4.884884884884885,4.916916916916917,4.932932932932933,4.964964964964965,5.077077077077077,5.1891891891891895,5.205205205205205,5.221221221221221,5.253253253253253,5.381381381381381,5.413413413413413,5.42942942942943,5.445445445445445,5.461461461461462,5.4774774774774775,5.541541541541542,5.573573573573573,5.637637637637638,5.66966966966967,5.685685685685685,5.701701701701702,5.925925925925926,6.006006006006006,6.07007007007007,6.134134134134134,6.182182182182182,6.2142142142142145,6.246246246246246,6.262262262262262,6.2942942942942945,6.326326326326326,6.342342342342342,6.358358358358358,6.374374374374375,6.39039039039039,6.406406406406406,6.4224224224224224,6.438438438438438,6.47047047047047,6.486486486486487,6.5025025025025025,6.534534534534535,6.55055055055055,6.614614614614615,6.63063063063063,6.646646646646647,6.7107107107107105,6.726726726726727,6.838838838838838,6.870870870870871,6.950950950950951,6.966966966966967,6.982982982982983,7.015015015015015,7.031031031031031,7.047047047047047,7.063063063063063,7.143143143143143,7.191191191191191,7.2392392392392395,7.287287287287287,7.31931931931932,7.351351351351351,7.367367367367367,7.415415415415415,7.5275275275275275,7.543543543543543,7.55955955955956,7.575575575575575,7.671671671671672,7.751751751751752,7.767767767767768,7.783783783783783,7.847847847847848,7.87987987987988,7.895895895895896,7.927927927927928,7.943943943943944,7.95995995995996,7.991991991991992,8.024024024024024,8.056056056056056,8.072072072072071,8.104104104104104,8.12012012012012,8.168168168168169,8.184184184184184,8.2002002002002,8.216216216216216,8.232232232232231,8.312312312312311,8.328328328328329,8.376376376376376,8.392392392392392,8.44044044044044,8.456456456456456,8.488488488488489,8.552552552552552,8.664664664664665,8.68068068068068,8.696696696696696,8.76076076076076,8.776776776776776,8.792792792792794,8.824824824824825,8.872872872872874,8.952952952952954,8.96896896896897,9.001001001001,9.017017017017016,9.065065065065065,9.113113113113114,9.145145145145145,9.177177177177176,9.20920920920921,9.225225225225225,9.353353353353354,9.401401401401401,9.465465465465465,9.481481481481481,9.561561561561561,9.577577577577577,9.60960960960961,9.657657657657657,9.817817817817819,9.92992992992993,9.945945945945946,10.042042042042041,10.058058058058059,10.09009009009009,10.106106106106106,10.138138138138139,10.186186186186186,10.218218218218219,10.234234234234235,10.25025025025025,10.266266266266266,10.298298298298299,10.314314314314315,10.33033033033033,10.362362362362362,10.41041041041041,10.426426426426426,10.49049049049049,10.538538538538539,10.586586586586586,10.602602602602602,10.618618618618619,10.682682682682682,10.714714714714715,10.73073073073073,10.746746746746746,10.762762762762762,10.794794794794795,10.842842842842844,10.85885885885886,10.874874874874875,10.986986986986986,11.035035035035035,11.05105105105105,11.083083083083084,11.0990990990991,11.13113113113113,11.163163163163164,11.17917917917918,11.195195195195195,11.21121121121121,11.25925925925926,11.275275275275275,11.37137137137137,11.451451451451451,11.4994994994995,11.531531531531531,11.595595595595595,11.611611611611611,11.627627627627627,11.723723723723724,11.835835835835836,11.867867867867869,11.8998998998999,11.915915915915916,11.995995995995996,12.092092092092091,12.108108108108109,12.124124124124124,12.172172172172171,12.204204204204204,12.22022022022022,12.236236236236236,12.268268268268269,12.284284284284285,12.3003003003003,12.316316316316316,12.332332332332332,12.348348348348349,12.396396396396396,12.428428428428429,12.492492492492492,12.556556556556556,12.572572572572572,12.652652652652652,12.66866866866867,12.7007007007007,12.716716716716716,12.74874874874875,12.972972972972974,13.005005005005005,13.02102102102102,13.037037037037036,13.06906906906907,13.085085085085085,13.117117117117116,13.133133133133134,13.14914914914915,13.18118118118118,13.213213213213214,13.22922922922923,13.245245245245245,13.26126126126126,13.30930930930931,13.46946946946947,13.485485485485485,13.54954954954955,13.565565565565565,13.613613613613614,13.645645645645645,13.661661661661661,13.677677677677677,13.741741741741741,13.94994994994995,13.965965965965966,13.981981981981981,13.997997997997999,14.03003003003003,14.078078078078079,14.094094094094094,14.126126126126126,14.19019019019019,14.206206206206206,14.254254254254255,14.27027027027027,14.302302302302301,14.318318318318319,14.35035035035035,14.462462462462462,14.494494494494495,14.51051051051051,14.542542542542542,14.558558558558559,14.574574574574575,14.622622622622622,14.702702702702702,14.734734734734735,14.814814814814815,14.83083083083083,14.95895895895896,15.03903903903904,15.055055055055055,15.11911911911912,15.167167167167166,15.247247247247246,15.263263263263264,15.35935935935936,15.375375375375375,15.391391391391391,15.407407407407407,15.43943943943944,15.487487487487487,15.51951951951952,15.535535535535535,15.551551551551551,15.567567567567567,15.5995995995996,15.631631631631631,15.695695695695695,15.727727727727727,15.75975975975976,15.791791791791791,15.807807807807807,15.823823823823824,15.83983983983984,15.855855855855856,15.903903903903904,15.935935935935936,15.967967967967969,15.983983983983984,16.0];
    output_spiketimes{2, 1} = [0.0,0.016016016016016016,0.03203203203203203,0.04804804804804805,0.08008008008008008,0.0960960960960961,0.11211211211211211,0.16016016016016016,0.1921921921921922,0.24024024024024024,0.3203203203203203,0.3363363363363363,0.3683683683683684,0.3843843843843844,0.40040040040040037,0.4164164164164164,0.44844844844844844,0.4964964964964965,0.5125125125125125,0.5445445445445445,0.5605605605605606,0.5765765765765766,0.6566566566566566,0.6726726726726726,0.6886886886886887,0.7207207207207207,0.7367367367367368,0.7687687687687688,0.8168168168168168,0.8328328328328328,0.8488488488488488,0.8648648648648649,0.8808808808808809,0.9129129129129129,0.9289289289289289,0.960960960960961,0.9769769769769769,1.009009009009009,1.025025025025025,1.0410410410410411,1.073073073073073,1.105105105105105,1.1211211211211212,1.1851851851851851,1.2012012012012012,1.2172172172172173,1.2652652652652652,1.3133133133133132,1.3453453453453452,1.3773773773773774,1.3933933933933933,1.4254254254254255,1.4414414414414414,1.4574574574574575,1.4894894894894894,1.5215215215215214,1.5375375375375375,1.6176176176176176,1.6336336336336337,1.6496496496496496,1.6816816816816818,1.6976976976976976,1.7137137137137137,1.7457457457457457,1.7937937937937938,1.8098098098098099,1.8418418418418419,1.8738738738738738,1.921921921921922,1.937937937937938,1.9539539539539539,2.002002002002002,2.018018018018018,2.034034034034034,2.13013013013013,2.146146146146146,2.178178178178178,2.21021021021021,2.274274274274274,2.29029029029029,2.3063063063063063,2.354354354354354,2.3703703703703702,2.3863863863863863,2.4024024024024024,2.4504504504504503,2.4824824824824825,2.4984984984984986,2.5145145145145147,2.5465465465465464,2.5785785785785786,2.6106106106106104,2.6586586586586587,2.674674674674675,2.6906906906906904,2.7067067067067065,2.7227227227227226,2.7867867867867866,2.8028028028028027,2.818818818818819,2.8668668668668666,2.8828828828828827,2.914914914914915,2.930930930930931,2.962962962962963,2.978978978978979,2.994994994994995,3.011011011011011,3.027027027027027,3.043043043043043,3.059059059059059,3.075075075075075,3.091091091091091,3.1071071071071072,3.155155155155155,3.171171171171171,3.1871871871871873,3.219219219219219,3.235235235235235,3.2672672672672673,3.315315315315315,3.3473473473473474,3.3633633633633635,3.3953953953953953,3.4114114114114114,3.4274274274274275,3.4594594594594597,3.4754754754754753,3.5075075075075075,3.5395395395395397,3.5875875875875876,3.6036036036036037,3.6196196196196198,3.6516516516516515,3.6676676676676676,3.6836836836836837,3.7157157157157155,3.7317317317317316,3.7477477477477477,3.7637637637637638,3.77977977977978,3.795795795795796,3.85985985985986,3.8918918918918917,3.923923923923924,3.93993993993994,3.987987987987988,4.004004004004004,4.052052052052052,4.084084084084084,4.132132132132132,4.18018018018018,4.196196196196196,4.212212212212212,4.228228228228228,4.308308308308308,4.324324324324325,4.356356356356356,4.372372372372372,4.388388388388388,4.404404404404405,4.436436436436437,4.4524524524524525,4.484484484484485,4.596596596596597,4.628628628628628,4.644644644644645,4.66066066066066,4.676676676676677,4.708708708708708,4.756756756756757,4.8208208208208205,4.836836836836837,4.852852852852853,4.868868868868869,4.884884884884885,4.900900900900901,4.916916916916917,4.932932932932933,4.948948948948949,4.964964964964965,4.996996996996997,5.013013013013013,5.029029029029029,5.061061061061061,5.109109109109109,5.141141141141141,5.1891891891891895,5.205205205205205,5.253253253253253,5.2692692692692695,5.285285285285285,5.317317317317317,5.34934934934935,5.365365365365365,5.381381381381381,5.413413413413413,5.42942942942943,5.445445445445445,5.461461461461462,5.525525525525525,5.541541541541542,5.573573573573573,5.58958958958959,5.605605605605605,5.637637637637638,5.66966966966967,5.685685685685685,5.701701701701702,5.717717717717718,5.74974974974975,5.7657657657657655,5.813813813813813,5.82982982982983,5.8458458458458455,5.877877877877878,5.893893893893894,5.90990990990991,5.925925925925926,5.941941941941942,5.957957957957958,5.973973973973974,6.054054054054054,6.07007007007007,6.102102102102102,6.134134134134134,6.15015015015015,6.166166166166166,6.182182182182182,6.2142142142142145,6.23023023023023,6.246246246246246,6.262262262262262,6.278278278278278,6.31031031031031,6.342342342342342,6.358358358358358,6.406406406406406,6.438438438438438,6.47047047047047,6.486486486486487,6.5025025025025025,6.55055055055055,6.566566566566567,6.5825825825825826,6.63063063063063,6.7107107107107105,6.726726726726727,6.742742742742743,6.758758758758758,6.7907907907907905,6.806806806806807,6.838838838838838,6.886886886886887,6.902902902902903,6.918918918918919,6.950950950950951,6.966966966966967,6.998998998998999,7.015015015015015,7.031031031031031,7.047047047047047,7.063063063063063,7.079079079079079,7.111111111111111,7.127127127127127,7.143143143143143,7.191191191191191,7.2392392392392395,7.287287287287287,7.335335335335335,7.351351351351351,7.367367367367367,7.383383383383383,7.3993993993994,7.495495495495495,7.511511511511512,7.5275275275275275,7.55955955955956,7.575575575575575,7.591591591591592,7.607607607607608,7.623623623623623,7.63963963963964,7.71971971971972,7.751751751751752,7.767767767767768,7.783783783783783,7.7997997997998,7.8158158158158155,7.831831831831832,7.847847847847848,7.87987987987988,7.895895895895896,7.911911911911912,7.927927927927928,7.943943943943944,7.991991991991992,8.008008008008009,8.024024024024024,8.04004004004004,8.056056056056056,8.072072072072071,8.104104104104104,8.136136136136136,8.168168168168169,8.2002002002002,8.216216216216216,8.248248248248249,8.28028028028028,8.312312312312311,8.376376376376376,8.392392392392392,8.456456456456456,8.472472472472472,8.488488488488489,8.536536536536536,8.552552552552552,8.568568568568569,8.632632632632632,8.664664664664665,8.696696696696696,8.744744744744745,8.76076076076076,8.776776776776776,8.792792792792794,8.824824824824825,8.84084084084084,8.856856856856856,8.872872872872874,8.904904904904905,8.984984984984985,9.001001001001,9.04904904904905,9.065065065065065,9.113113113113114,9.145145145145145,9.177177177177176,9.20920920920921,9.24124124124124,9.257257257257256,9.273273273273274,9.337337337337337,9.44944944944945,9.481481481481481,9.497497497497497,9.545545545545545,9.577577577577577,9.641641641641641,9.657657657657657,9.68968968968969,9.721721721721721,9.737737737737739,9.753753753753754,9.817817817817819,9.833833833833834,9.84984984984985,9.881881881881881,9.913913913913914,9.92992992992993,9.945945945945946,9.977977977977979,10.01001001001001,10.026026026026026,10.058058058058059,10.09009009009009,10.106106106106106,10.154154154154154,10.186186186186186,10.202202202202201,10.218218218218219,10.234234234234235,10.25025025025025,10.266266266266266,10.298298298298299,10.314314314314315,10.33033033033033,10.41041041041041,10.426426426426426,10.442442442442442,10.458458458458459,10.474474474474475,10.522522522522522,10.538538538538539,10.554554554554555,10.57057057057057,10.602602602602602,10.634634634634635,10.65065065065065,10.682682682682682,10.714714714714715,10.73073073073073,10.746746746746746,10.762762762762762,10.794794794794795,10.826826826826826,10.842842842842844,10.85885885885886,10.874874874874875,10.954954954954955,10.97097097097097,10.986986986986986,11.01901901901902,11.083083083083084,11.0990990990991,11.115115115115115,11.13113113113113,11.147147147147146,11.163163163163164,11.17917917917918,11.195195195195195,11.21121121121121,11.243243243243244,11.25925925925926,11.275275275275275,11.33933933933934,11.355355355355355,11.37137137137137,11.451451451451451,11.467467467467467,11.483483483483484,11.4994994994995,11.515515515515515,11.531531531531531,11.563563563563564,11.57957957957958,11.611611611611611,11.627627627627627,11.707707707707707,11.723723723723724,11.755755755755755,11.787787787787789,11.81981981981982,11.835835835835836,11.851851851851851,11.867867867867869,11.915915915915916,11.963963963963964,11.97997997997998,11.995995995995996,12.092092092092091,12.108108108108109,12.124124124124124,12.156156156156156,12.172172172172171,12.188188188188189,12.204204204204204,12.22022022022022,12.236236236236236,12.268268268268269,12.284284284284285,12.3003003003003,12.332332332332332,12.348348348348349,12.38038038038038,12.428428428428429,12.444444444444445,12.46046046046046,12.476476476476476,12.492492492492492,12.508508508508509,12.556556556556556,12.572572572572572,12.588588588588589,12.604604604604605,12.62062062062062,12.66866866866867,12.7007007007007,12.716716716716716,12.732732732732732,12.74874874874875,12.764764764764765,12.78078078078078,12.82882882882883,12.892892892892894,12.924924924924925,12.972972972972974,13.02102102102102,13.037037037037036,13.06906906906907,13.085085085085085,13.1011011011011,13.117117117117116,13.14914914914915,13.18118118118118,13.197197197197196,13.22922922922923,13.245245245245245,13.26126126126126,13.277277277277276,13.325325325325325,13.357357357357357,13.38938938938939,13.421421421421421,13.437437437437437,13.453453453453454,13.485485485485485,13.501501501501501,13.533533533533534,13.54954954954955,13.565565565565565,13.581581581581581,13.613613613613614,13.62962962962963,13.645645645645645,13.661661661661661,13.677677677677677,13.70970970970971,13.725725725725725,13.741741741741741,13.78978978978979,13.821821821821821,13.853853853853854,13.94994994994995,13.965965965965966,14.014014014014014,14.046046046046046,14.078078078078079,14.094094094094094,14.11011011011011,14.126126126126126,14.142142142142141,14.158158158158159,14.19019019019019,14.206206206206206,14.238238238238239,14.254254254254255,14.27027027027027,14.302302302302301,14.334334334334335,14.35035035035035,14.366366366366366,14.446446446446446,14.51051051051051,14.526526526526526,14.542542542542542,14.574574574574575,14.622622622622622,14.63863863863864,14.654654654654655,14.67067067067067,14.686686686686686,14.702702702702702,14.734734734734735,14.766766766766766,14.782782782782782,14.7987987987988,14.83083083083083,14.91091091091091,14.926926926926926,14.942942942942944,14.95895895895896,14.99099099099099,15.03903903903904,15.055055055055055,15.11911911911912,15.135135135135135,15.167167167167166,15.1991991991992,15.215215215215215,15.23123123123123,15.247247247247246,15.263263263263264,15.27927927927928,15.31131131131131,15.327327327327327,15.343343343343344,15.35935935935936,15.375375375375375,15.391391391391391,15.407407407407407,15.423423423423424,15.43943943943944,15.471471471471471,15.487487487487487,15.51951951951952,15.551551551551551,15.567567567567567,15.5995995995996,15.615615615615615,15.631631631631631,15.647647647647647,15.663663663663664,15.695695695695695,15.727727727727727,15.75975975975976,15.791791791791791,15.807807807807807,15.823823823823824,15.83983983983984,15.855855855855856,15.871871871871871,15.903903903903904,15.935935935935936,15.951951951951951,15.967967967967969,16.0];
end