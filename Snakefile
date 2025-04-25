"""
@modified: 19/11/22
@main_dev: Hugues Herrmann
"""

### ========== Variables ========== ###
# Config variables
OUT_DIR = config["out_dir"]
DESIGN = config["design"]
K_FOLD = config["k_fold"]
N_REPEATS = config["n_repeats"] if "n_repeats" in config else 1

# Optional
SEED = config["seed"] if "seed" in config else 2022


### ========== Global variables ========== ###
n_repeat: list = list(range(N_REPEATS))
k_fold_indices: list = list(range(K_FOLD))


### ========== Rules ========== ###
rule all:
    input:
        split_cv_train = expand(OUT_DIR + "train{n}_{k}.tsv", k = k_fold_indices, n = n_repeat),
        split_cv_test = expand(OUT_DIR + "test{n}_{k}.tsv", k = k_fold_indices, n = n_repeat)


rule split_cross_validation:
    input:
        design = DESIGN
    output:
        split_cv_train = expand(OUT_DIR + "train{n}_{k}.tsv", k = k_fold_indices, n = n_repeat),
        split_cv_test = expand(OUT_DIR + "test{n}_{k}.tsv", k = k_fold_indices, n = n_repeat)
    params:
        k = K_FOLD,
        out_dir = OUT_DIR
    run:
        for n in range(N_REPEATS):
            shell("bash scripts/split_cv.sh -i {design} -k {k} -o {out_dir} -s {seed}".format(design = input.design, k = params.k, out_dir = params.out_dir, seed = n + 10))
            for k in range(K_FOLD):
                shell("for file in {out_dir}sampleshuf.train{k}.tsv; do mv $file {out_dir}train{n}_{k}.tsv; done".format(out_dir = params.out_dir, n = n, k = k))
                shell("for file in {out_dir}sampleshuf.test{k}.tsv; do mv $file {out_dir}test{n}_{k}.tsv; done".format(out_dir = params.out_dir, n = n, k = k))
