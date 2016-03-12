<?lasso
/*----------------------------------------------------------------------------
[pagination]
Generates pagination links for navigating search results, converting webrequest parameters into a query string.
Author: Steve Piercy
Last Modified: 2016-03-11
License: MIT License
Description:
This Lasso method outputs "Google-like" pagination links in Twitter Bootstrap 3 style, including links for first page, previous page, a user-definable range of nearby pages, next page, and last page.

It automatically includes all parameters passed to the current page, leaving the parameters visible on the query string so that users may share their search results. Passes parameters called -found and -skipped containing the appropriate values for -maxrecords and -skiprecords to be used in the query that generates the results.

Output can be styled using a class called "pagination".

Requires [wrp] from <https://gist.github.com/stevepiercy/4f51a05a752f1b554c7f>.

Sample Usage:
pagination(
    -found=149,
    -shown=10,
    -skipped=wrp('skipped')->asinteger,
    -range=6
)

Latest version available from <https://github.com/stevepiercy/pagination>.
----------------------------------------------------------------------------*/
log_critical('Loading: pagination')
define pagination(
        -found::integer=0,
        -shown::integer=0,
        -skipped::integer=0,
        -range::integer=0
) => {
// Generates pagination links for navigating search results.

    local(
        found_count = (local_defined('found') ? #found | found_count),
        shown_count = (local_defined('shown') ? #shown | maxrecords_value),
        shown_page = integer,
        skip_counts = array,
        skip = (local_defined('skipped') ? #skipped | skiprecords_value),
        counter = 0,
        radius = 2,
        display = string,
        prev = string,
        next = string,
        first = string,
        last = string,
        lower = integer,
        upper = integer,
        out = string
    )

    // no navigation is needed if #found_count <= #shown_count
    if(#found_count > #shown_count) => {
        // range defaults to 5
        !local_defined('range') ? local(range) = 5
        #radius = #range / 2

        // create the query string
        local(qs) = '?'
        with p in wrps
        where #p->second != '' && #p->first != 'skipped'
            do => {
                #qs -> append(#p->first + '=' + #p->second + '&')
            }

        // calculate number of pages
        local(pages) = #found_count / #shown_count
        #found_count % #shown_count > 0 ? #pages += 1

        // calculate skip count for each page
        loop(#pages) => {
            #skip_counts -> insert(#counter)
            #counter += #shown_count
        }

        // find the current page
        if(#skip > #found_count) => {
            // set a limit
            #shown_page = #skip_counts -> size
            #skip = #skip_counts -> last
        else(#skip < 0)
            #shown_page = 0
            #skip = 0
        else
            #shown_page = #skip_counts -> findposition(#skip) -> get(1)
        }

        // determine range of pages to show
        #lower = #skip - (#shown_count * #radius)
        #upper = #skip + (#shown_count * #radius)

        // find previous/next, first/last links
        #first = '
        <li' + (#shown_page <= 1 ? ' class="disabled"') + '>'+ (#shown_page <= 1 ? '<span>' | '<a href="' + #qs + 'skipped=0" aria-label="First">') + '<span aria-hidden="true">&laquo;</span>' + (#shown_page <= 1 ? '</span>' | '</a>') + '</li>'
        #prev = '
        <li' + (#shown_page <= 1 ? ' class="disabled"') + '>'+ (#shown_page <= 1 ? '<span>' | '<a href="' + #qs + 'skipped=' + (#skip - #shown_count) +  '" aria-label="Previous">') + '<span aria-hidden="true">&lsaquo;</span>' + (#shown_page <= 1 ? '</span>' | '</a>') + '</li>'

        #next = '
        <li' + (#shown_page >= #skip_counts -> size ? ' class="disabled"') + '>'+ (#shown_page >= #skip_counts -> size ? '<span>' | '<a href="' + #qs + 'skipped=' + (#skip + #shown_count) +  '" aria-label="Next">') + '<span aria-hidden="true">&rsaquo;</span>' + (#shown_page >= #skip_counts -> size ? '</span>' | '</a>') + '</li>'
        #last = '
        <li' + (#shown_page >= #skip_counts -> size ? ' class="disabled"') + '>'+ (#shown_page >= #skip_counts -> size ? '<span>' | '<a href="' + #qs + 'skipped=' + (#skip_counts -> last) +  '" aria-label="Last">') + '<span aria-hidden="true">&raquo;</span>' + (#shown_page >= #skip_counts -> size ? '</span>' | '</a>') + '</li>'
        
        // generate individual page nav links
        iterate(#skip_counts, local(this)) => {
            if(#this >= #lower && #this <= #upper) => {
                #display -> append('
        <li' + (#shown_page == loop_count ? ' class="active"') + '><a href="' + #qs + 'skipped=' + #this + '">')
                #display -> append(loop_count->asstring)
                #display -> append((#shown_page == loop_count ? ' <span class="sr-only">(current)</span>') +'</a></li>')
            }
        }

        #out = ('
<nav>
    <ul class="pagination">' + #first + #prev + #display + #next + #last + '
    </ul>
</nav>')
        return(@#out)
    }
}
log_critical('Done:    pagination')
?>
