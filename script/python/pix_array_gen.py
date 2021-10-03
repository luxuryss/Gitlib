num_pix         = 2
num_echo        = 4
pix_fir_max     = []
pix_fir_index   = []
pix_flag        = []
pix_dc          = []
pix_mean        = []
pix_noise       = []

def read_pix():
    global pix_fir_max
    global pix_fir_index
    global pix_flag
    global pix_dc
    global pix_mean
    global pix_noise
    echo_fir_max     = [0, 0, 0, 0]
    echo_fir_index   = [0, 0, 0, 0]
    echo_flag        = [0, 0, 0, 0]
    echo_dc          = [0, 0, 0, 0]
    file_fir_max    = open("./sim_data/fir_max.txt", "r")
    file_fir_index  = open("./sim_data/fir_index.txt", "r")
    file_flag       = open("./sim_data/flag.txt", "r")
    file_dc         = open("./sim_data/dc.txt", "r")
    file_mean       = open("./sim_data/mean.txt", "r")
    file_noise      = open("./sim_data/noise.txt", "r")
    for i in range(num_pix):
        for j in range(num_echo):
            echo_fir_max[j]     = file_fir_max.readline().replace("\n", "")
            echo_fir_index[j]   = file_fir_index.readline().replace("\n", "")
            echo_flag[j]        = file_flag.readline().replace("\n", "")
            echo_dc[j]          = file_dc.readline().replace("\n", "")
        pix_fir_max.append(echo_fir_max)            # change to deep copy !!!
        pix_fir_index.append(echo_fir_index)
        pix_flag.append(echo_flag)
        pix_dc.append(echo_dc)
        pix_mean.append(file_mean.readline().replace("\n", ""))
        pix_noise.append(file_noise.readline().replace("\n", ""))
    print(">>>>>>>>>> pix_fir_max:")
    print(pix_fir_max)
    print(">>>>>>>>>> pix_fir_index:")
    print(pix_fir_index)
    print(">>>>>>>>>> pix_flag:")
    print(pix_flag)
    print(">>>>>>>>>> pix_dc:")
    print(pix_dc)
    print(">>>>>>>>>> pix_mean:")
    print(pix_mean)
    print(">>>>>>>>>> pix_noise:")
    print(pix_noise)

read_pix()