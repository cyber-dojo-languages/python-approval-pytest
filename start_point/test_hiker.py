import hiker
from approvaltests.approvals import verify

def test_life_the_universe_and_everything():
    '''a simple example to start you off'''
    douglas = hiker.Hiker()
    result = str(douglas.answer())
    verify(result)
