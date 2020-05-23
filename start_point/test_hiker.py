import hiker
from approvaltests.approvals import verify

def test_simple():
    '''a simple example to start you off'''
    douglas = hiker.Hiker()
    verify(str(douglas.answer()))
