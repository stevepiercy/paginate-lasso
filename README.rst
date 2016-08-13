pagination-lasso
================

``[pagination]`` is a method written in Lasso 9 that outputs pagination links
using `Twitter Bootstrap 3 style
<http://getbootstrap.com/components/#pagination>`_, including links for first
page, previous page, a user-definable range of nearby pages, next page, and
last page.

Output of the pagination widget can be styled using a CSS class named
``pagination``.

``[pagination]`` automatically includes all parameters passed to the current
page in the navigation links so that users may share their search results by
copying the URL. It accepts the following parameters

``-found``
    Used by Lasso as ``-maxrecords``. Used in the query string to generate the
    results.

``-skipped``
    Used by Lasso as ``-skiprecords``. Used in the query string to generate
    the results.

``-shown``
    The maximum number of records to show per page.

``-range``
    The number of nearby page links to display in the pagination widget,
    defaulting to 5, where the radius around the current page is one-half that
    of ``-range``.


Demonstration
-------------
A working example that demonstrates `pagination-lasso` is on the website for
`SelecTree
<https://selectree.calpoly.edu/search/?search_tree_name=a&button_search=Search>`_.
This link executes a query for trees in which their names contain the letter
"a". This returns at least fifty records, so that the pagination links will be
displayed. This demonstration was written with `Knop
<https://github.com/knop-project/knop>`_, an open source web application
framework using Lasso 8.x or 9.x.


Requirements
------------
`[wrp] <https://gist.github.com/stevepiercy/4f51a05a752f1b554c7f>`_.


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
`Latest version <https://github.com/stevepiercy/pagination>`_.
