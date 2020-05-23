import hiker
from approvaltests.approvals import verify

def test_hhgttg():
    '''a simple example to start you off'''
    douglas = hiker.Hiker()
    result = str(douglas.answer())
    verify(result)
