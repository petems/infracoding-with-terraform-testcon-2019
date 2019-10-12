#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""Test suite for Terraform resources."""

import os
import unittest
import terraform_validate


class TestResources(unittest.TestCase):
    """Tests related to resources."""

    def setUp(self):
        self.path = os.path.join(os.path.dirname(
            os.path.realpath(__file__)), '../.')
        self.validator = terraform_validate.Validator(self.path)

    def test_tags(self):
        """Checks resources for required tags."""
        tagged_resources = [
            'aws_instance'
        ]
        required_tags = ['Name']
        self.validator.error_if_property_missing()
        self.validator.resources(tagged_resources).property('tags'). \
            should_have_properties(required_tags)

if __name__ == '__main__':
    SUITE = unittest.TestLoader().loadTestsFromTestCase(TestResources)
    unittest.TextTestRunner(verbosity=0).run(SUITE)

# vim:ts=4:sw=4:expandtab
