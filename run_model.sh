#variables
data=$(date +'%Y-%m-%dT%H:%M:%S')

#paths
path_to_root='/home/valquiriaam/repos/PA005'
path_to_env='/home/valquiriaam/.pyenv/versions/pa005/bin'

$path_to_env/papermill $path_to_root/src/models/pa005_05_deploy_local.ipynb $path_to_root/reports/pa005_05_deploy_local$data.ipynb
