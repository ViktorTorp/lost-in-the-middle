# Lost in the Middle: How Language Models Use Long Contexts (Fork)

This repository is a fork of [Lost in the Middle: How Language Models Use Long Contexts](https://arxiv.org/abs/2307.03172), expanded for additional experiments conducted as part of my master's thesis.

This fork extends the original work with additional experiments for my master's thesis. The aim is to replicate the lost-in-the-middle effect using GPT and LLama.
Additionally we also included some mitigation methods and new metrics.

## How to run these experiments

```sh
$ bash run_gpt.sh
$ bash run_gpt_baseline.sh
$ bash run_llama.sh
$ bash run_llama_baseline.sh
$ bash run_llama70b.sh
$ bash run_llama70b_baseline.sh
$ bash run_uncertainities.sh
```

## Multi-Document Question Answering results and analysis

Run the notebook notebook/11_thesis_plots.ipynb to replicate the plots from this thesis.

## References the original work "Lost in the Middle: How Language Models Use Long Contexts"

```
@misc{liu-etal:2023:arxiv,
  author    = {Nelson F. Liu  and  Kevin Lin  and  John Hewitt  and Ashwin Paranjape  and Michele Bevilacqua  and  Fabio Petroni  and  Percy Liang},
  title     = {Lost in the Middle: How Language Models Use Long Contexts},
  note      = {arXiv:2307.03172},
  year      = {2023}
}
```
