c = get_config()
### If you want to auto-save .html and .py versions of your notebook:
# modified from: https://github.com/ipython/ipython/issues/8009
import os
import pathlib
import shutil
from subprocess import check_call
from davinci import path

report_path = os.path.join(os.environ['CODE_HOME'], 'Data_Analysis', 'First', 'data_analysis', 'reports')

def post_save(model, os_path, contents_manager):
    """post-save hook for converting notebooks to .py scripts"""
    if model['type'] != 'notebook':
        return # only do this for notebooks
    d, fname = os.path.split(os_path)
    dd, d_name = os.path.split(d)
    print(dd)
    if 'data_analysis' in dd and 'Untitled' not in dd and 'Report-' in fname:
        html_file = fname.replace('.ipynb', '.html')
        input_html = os_path.replace('.ipynb', '.html')
        output_html = os.path.join(report_path, d_name, html_file)
        # generate html files
        check_call(['jupyter', 'nbconvert', '--to', 'html',
            fname, '--template=report.tpl'], cwd=d)
        # create directory if not exists
        directory = os.path.join(report_path, d_name)
        print(directory)
        pathlib.Path(directory).mkdir(parents=True, exist_ok=True)
        # if not os.path.exists(directory):
        #     os.makedirs(directory)
        # move html and py files to new directory under report folder
        shutil.move(input_html, output_html)
        # check_call(['mv', input_py, output_py], cwd=d)
        # check_call(['mv', output_html, output_html], cwd=d)
        print("finished moving files to {}".format(directory))

c.FileContentsManager.post_save_hook = post_save
c.NotebookApp.open_browser = False
