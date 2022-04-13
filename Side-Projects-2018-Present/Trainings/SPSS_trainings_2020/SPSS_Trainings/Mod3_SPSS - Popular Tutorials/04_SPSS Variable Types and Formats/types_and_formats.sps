** MY NOTES: display dictionary shows var types more accurately than variable view of data editor.
display dictionary.

** MY NOTES: setting var formats for num type variables.
formats pweight (f4.3).

*Show 2 decimal places for weight and run descriptives.
formats pweight(f3.2).
descriptives pweight.

*Show 3 decimal places for weight and run descriptives.
formats pweight(f4.3).
descriptives pweight.

*Note that second output table shows more decimal places.

** MY NOTES: using logical to filter var by value.
compute expensive = (price >= 20).

** MY NOTES: adding 30 days to date variable .
compute newdate = datesum(date,30,'days').

** MY NOTES: applying date format to date var in num format .
formats newdate (date11).


** MY NOTES: applying formats to writing tables.
*Create basic descriptives table.

descriptives pweight.

*Set 2 decimal places (format = f3.2) for mean and SD (columns 4 and 5).

output modify
/select tables
/tablecells select = [position(4) position(5)] selectdimension = columns format = 'f3.2'.


*Create descriptives table with different decimal places for different statistics.
ctables
/table commission [count 'N' f3 Minimum pct3 Maximum pct3 mean 'Mean' pct4.1 stddev 'SD' pct4.1].




