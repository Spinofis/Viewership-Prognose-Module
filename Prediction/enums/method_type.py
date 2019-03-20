from enum import IntEnum

class Method_type(IntEnum):
    Cnn_multivariate_multistep=1,
    Naive_avg_yesterday=2,
    Cnn_multivariate_singlestep=3