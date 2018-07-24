./update_data_view.sh
#FORCE=1 taste-generate-skeletons

ORCHESTRATOR_OPTIONS+=" --no-retry"

echo "ORCHESTRATOR_OPTIONS=$ORCHESTRATOR_OPTIONS"

# Clean PYTHONPATH of site-packages folders (which may cause problems of Python 2 vs. 3, e.g., for OpenGEODE)
echo "Cleaning Python envionrment variables"
export PYTHONPATH=`echo $PYTHONPATH | sed "s/[^:]*site-packages://g"`
unset PYTHONUSERBASE
echo "PYTHONPATH=$PYTHONPATH"
echo "PYTHONUSERBASE unset"
