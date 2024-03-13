# LLAMA2 Chinese

```SHELL
conda create -n qlllama2 python=3.8
conda activate qlllama2
conda deactivate
conda remove -n qlllama2 --all

pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

torchrun --nproc_per_node=8 train.py --train_args_file train_args/llama2-13b-ext.yaml

```

## 报错记录

* libbitsandbytes_cpu 版本不对导致的

  ```shell
  python3.8/site-packages/bitsandbytes/libbitsandbytes_cpu.so: undefined symbol: cquantize_blockwise_fp16_nf4
  ```
  用自己的CUDA版本覆盖
  ```SHELL
  cd python3.8/site-packages/bitsandbytes
  cp libbitsandbytes_cuda121.so libbitsandbytes_cpu.so
  ```
