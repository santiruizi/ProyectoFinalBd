import unittest
import sys
import os

# Add root to path so we can import test
sys.path.append(os.getcwd())

from test.test_connection import TestConnection

if __name__ == '__main__':
    suite = unittest.TestLoader().loadTestsFromTestCase(TestConnection)
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    if not result.wasSuccessful():
        sys.exit(1)
