# README
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

MATLAB_R2015a only runs up to Python 3.4, so we create a new virtual environment called `jmatlab`
```
conda create -vv -n jmatlab python=3.4 jupyter
```
If you screw up and create something that doesn't work, follow the steps here to delete: https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#removing-an-environment

Activate the environment
```
source activate jmatlab
```

Install the required packages
```
pip install matlab_kernel

python -m matlab_kernel install
```

Verify kernel installation
```
jupyter kernelspec list
```

### MATLAB

```
cd /Applications/MATLAB_R2015a.app/extern/engines/python

python setup.py install
```

## Set up `readthedocs`
Following along here: https://docs.readthedocs.io/en/latest/intro/getting-started-with-sphinx.html

Install sphinx
```
pip install sphinx
```

Start sphinx in repo
```
cd ~/Projects/intro_acoustics/docs
sphinx-quickstart
```
