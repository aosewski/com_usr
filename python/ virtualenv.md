# `virtualenv`

## installation
```bash
pip install virtualenv
virtualenv --version
```
### Create a virtual environment for a project:
```bash
virtualenv -p /usr/bin/python3 <my_project_name>
```
`virtualenv my_project` will create a folder in the current directory which will contain the Python executable files, and a copy of the `pip` library which you can use to install other packages. The name of the virtual environment (in this case, it was `my_project`) can be anything; omitting the name will place the files in the current directory instead.

This creates a copy of Python in whichever directory you ran the command in, placing it in a folder named my_project.

change the interpreter globally with an env variable in `~/.bashrc`:
```bash
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
```
To begin using the virtual environment, it needs to be activated:
```bash
source <my_project>/bin/activate
```
From now on, any package that you install using pip will be placed in the `my_project` folder, isolated from the global Python installation
To stop working in environment run: `deactivate`.

Running `virtualenv` with the option `--no-site-packages` will not include the packages that are installed globally (in newer versions starting from 1.7 it's the default behavior).

### Removing virtual env
To delete a virtual environment, just delete its folder. (In this case, it would be `rm -rf my_project`.)

### Backup and restore installed  packages
In order to keep your environment consistent, it’s a good idea to “freeze” the current state of the environment packages. To do this, run
```bash
pip freeze > requirements.txt
```
This will create a `requirements.txt` file, which contains a simple list of all the packages in the current environment, and their respective versions. 

You can see the list of installed packages without the requirements format using `pip list`. Later it will be easier for a different developer (or you, if you need to re-create the environment) to install the same packages using the same versions:
```bash
pip install -r requirements.txt
```
