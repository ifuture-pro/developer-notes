Jupyter Notebook
----------

* [jupyter notebook](https://jupyter.org/)
  * [JupyterHub](https://github.com/jupyterhub/jupyterhub)
  * [Beaker Extensions](https://github.com/twosigma/beakerx)
* [zeppelin notebook](https://zeppelin.apache.org/)
* [metaflow](https://github.com/Netflix/metaflow)

## 安装
```shell
pip install notebook

jupyter notebook --port 8888 --ip 192.168.0.100

jupyter notebook --help


```

使用虚拟环境
```shell
# 安装
pip install virtualenv
# 创建虚拟环境
virtualenv --no-site-packages my_venv
# 进入虚拟环境
source my_venv/bin/activate

pip install ipykernel
# 将 Virtualenv 加入IPykernel中
# ipython kernel install --user --name=my_venv
python -m ipykernel install --user --name=my_venv

# 启动jupyter
jupyter notebook

```

```SHELL
conda create -n name python=3.6
conda info --envs
conda activate name
conda deactivate
conda remove -n name --all
```

## pip源
```shell
pip install <包名> -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn
```

## 插件
```
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
pip install jupyter_nbextensions_configurator
jupyter nbextensions_configurator enable --user
重启 Jupyter Notebook， 便可以看到nbextension
jupyter nbextension enable execute_time/Exec
```

```
%magic #显示所有魔术命令的详细文档
%prun statement #通过 cProfile 执行对 statement 的逐行性能分析
%time statement #测试 statement 的执行时间
%timeit statement #多次测试 statement 的执行时间并计算平均值
```
