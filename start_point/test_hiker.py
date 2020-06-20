from hiker import global_answer, Hiker
from approvaltests.approvals import verify


def test_global():
    result = str(global_answer())
    verify(result)

def test_instance():
    result = str(Hiker().instance_answer())
    verify(result)
