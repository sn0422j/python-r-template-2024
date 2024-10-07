from rpy2 import robjects
from rpy2.robjects.vectors import FloatVector

robjects.r("array <- c(1,2,3,4,5,6)")
result = robjects.r("mean(array)")
assert isinstance(result, FloatVector)
print(result[0])
