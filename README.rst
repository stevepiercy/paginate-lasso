pagination-lasso
================

This Lasso method outputs pagination links using `Twitter Bootstrap 3 style
<http://getbootstrap.com/components/#pagination>`_, including links for first
page, previous page, a user-definable range of nearby pages, next page, and
last page.

It automatically includes all parameters passed to the current page in the
navigation links so that users may share their search results by copying the
URL. It passes parameters called ``-found`` and ``-skipped`` containing the
appropriate values for ``-maxrecords`` and ``-skiprecords`` to be used in the
query that generates the results.

Output can be styled using a class called ``pagination``.


Demonstration
-------------
A working example that demonstrates `pagination-lasso` is on the website for
`SelecTree <https://selectree.calpoly.edu/>`_. If the search result has at
least fifty records, then the pagination links will be displayed.


Requirements
------------
`wrp <https://gist.github.com/stevepiercy/4f51a05a752f1b554c7f>`_.


Sample usage
------------

.. code-block:: lasso

    pagination(
        -found=149,
        -shown=10,
        -skipped=wrp('skipped')->asinteger,
        -range=6
    )


Download
--------
`Latest version <https://github.com/stevepiercy/pagination>`_


