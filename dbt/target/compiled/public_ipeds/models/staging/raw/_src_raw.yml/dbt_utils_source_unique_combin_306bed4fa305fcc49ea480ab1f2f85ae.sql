





with validation_errors as (

    select
        unitid, cipcode, majornum, awlevel
    from `data-eng-ipeds`.`raw`.`c2018_a`
    group by unitid, cipcode, majornum, awlevel
    having count(*) > 1

)

select *
from validation_errors


