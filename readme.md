# Introduction to Acoustics
Overview of essential tools and concepts for bioacoustics research

## Start a notebook

Follow these steps to start a notebook if you already have everything set up. If not, see the next section.
```
# activate the python environment
source activate jmatlab

# move to the project directory
cd ~/Projects/intro_acoustics/docs/

# start up jupyter notebooks
jupyter notebook
```

## Setting Jupyter Notebook for MATLAB

Follow the tutorial here: https://am111.readthedocs.io/en/latest/jmatlab_install.html

### Python

1. Create a virtual environment (called `jmatlab`) to run a version of Python compatible with matlab. I'm using MATLAB_R2015a, which only runs up to Python 3.4.
```
conda create -vv -n jmatlab python=3.4 jupyter
```
If you screw up and create something that doesn't work, follow the steps here to delete: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#removing-an-environment

2. Activate the environment
```
source activate jmatlab
```

3. Install the required packages
```
pip install matlab_kernel

python -m matlab_kernel install
```

4. Verify kernel installation
```
jupyter kernelspec list
```

### MATLAB

1. Set up external Python engine
```
cd /Applications/MATLAB_R2015a.app/extern/engines/python

python setup.py install
```

## Set up `readthedocs`

### Set up sphinx

Following along here: https://docs.readthedocs.io/en/latest/intro/getting-started-with-sphinx.html

1. Install sphinx
```
pip install sphinx
```

2. Start sphinx in repo
```
cd ~/Projects/intro_acoustics/docs
sphinx-quickstart
```
3. Advance through prompts, selecting [almost] all defaults.

4. Install pretty theme
```
pip install sphinx_rtd_theme
```

### Set up nbsphinx to parse `.ipynb` files

Following along here: https://nbsphinx.readthedocs.io/en/0.4.2/

1. Install nbsphinx
```
pip install nbsphinx
```
2. Open `docs/conf.py` and add `'nbsphinx'` to `extensions`
3. Add `*.ipynb` files to `toctree` in `index.rst`
