import pytest
from app.api.dummy import dummy_function

def test_dummy():
    ret = dummy_function(3)
    assert 3 == ret
