ReadMe

This repository contains data to replicate all tables and figures in the paper "How do parents perceive the returns to parenting styles and neighborhoods?" by Lukas Kiessling (lukas.kiessling@gmail.com).

This code for the paper is based on a (older version of a) template for reproducible research projects in economics (https://econ-project-templates.readthedocs.io/en/v0.3.3/) and waf (https://waf.io/).

The code was written and tested with Python 3.7.10 from the Anaconda distribution (to run the template) and Stata 15.1 (for statistical analyses). To run the template, first make sure that Python and Stata are added to your PATH (see here for troubleshooting tips for different operating systems). Probably, the template works out of the box with your python base version, if not, set up a virtual environment using conda (conda env create -f environment.yml) and activate the environment (conda activate parental_beliefs).

To run the template, run the following code:

python waf.py configure
python waf.py build

The first command sets up all relevant path variables that are used in the project (e.g., pointers to packages, folders, and files; see the created file bld/project_paths.do), the second runs the template and several Stata instances. All source files are located in "src", all created files can be found in "bld" after running the commands. If you want to run a specific script from in Stata's do-file editor, make sure to run the projects_paths.do-file first.
