<?php

namespace Tests;

class BaseTest extends TestCase
{
    public function setUp(): void
    {
        parent::setUp();

        /**
         * Allows for more easily seeing HTTP errors from the test output
         */
        // $this->withoutExceptionHandling();
    }
}
