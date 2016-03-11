paginate-lasso
==============

This Lasso method outputs "Google-like" pagination links in Twitter Bootstrap
3 style, including links for first page, previous page, a user-definable range
of nearby pages, next page, and last page.

It automatically includes all parameters passed to the current page, leaving
the parameters visible on the query string so that users may share their
search results. Passes parameters called ``-found`` and ``-skipped``
containing the appropriate values for ``-maxrecords`` and ``-skiprecords`` to
be used in the query that generates the results.

Output can be styled using a class called "pagination."

Requires `wrp <https://gist.github.com/stevepiercy/4f51a05a752f1b554c7f>`_.

Sample Usage:

.. code-block:: lasso

    pagination(
        -found=149,
        -shown=10,
        -skipped=wrp('skipped')->asinteger,
        -range=6
    )

`Latest version <https://github.com/stevepiercy/pagination>`_.

