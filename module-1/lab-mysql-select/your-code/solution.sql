-- Challenge 1
select A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME,
    T.TITLE,
    P.PUB_NAME
from authors A,
	titleauthor TA,
    titles T,
    PUBLISHERS P
where A.AU_ID = TA.AU_ID
	and TA.TITLE_ID = T.TITLE_ID
    and T.PUB_ID = P.PUB_ID;


-- Challenge 2
select A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME,
    -- T.TITLE,
    P.PUB_NAME,
    count(T.TITLE) as titles_num
from authors A,
	titleauthor TA,
    titles T,
    PUBLISHERS P
where A.AU_ID = TA.AU_ID
	and TA.TITLE_ID = T.TITLE_ID
    and T.PUB_ID = P.PUB_ID
group by A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME,
    -- T.TITLE,
    P.PUB_NAME
;
-- Challenge 3
select A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME,
    sum(qty) as ventas
from authors A,
	titleauthor TA,
    titles T,
    sales S
where A.AU_ID = TA.AU_ID
	and TA.TITLE_ID = T.TITLE_ID
    and T.TITLE_ID = S.TITLE_ID
group by A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME
order by ventas desc
LIMIT 3
;
-- Challenge 4
select A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME,
    sum(coalesce(qty,0)) as ventas
from authors A
	left join titleauthor TA on A.AU_ID = TA.AU_ID
    left join titles T on TA.TITLE_ID = T.TITLE_ID
    left join sales S on T.TITLE_ID = S.TITLE_ID
group by A.AU_ID,
	A.AU_LNAME,
    A.AU_FNAME
order by ventas desc
-- LIMIT 23
;



-- INTENTO DE BONUS
select D.AU_ID as `AUTHOR ID`,
    D.au_lname as `LAST NAME`,
	D.au_fname as `FIRST NAME`,
    sum(round(A.ventas_a_repartir*royaltyper/100 + B.advance*royaltyper/100,2)) as PROFIT
from 
	(select T.TITLE_ID, T.price * S.qty * T.royalty/100 as ventas_a_repartir
	from titles T, sales S
	where T.TITLE_ID = S.TITLE_ID) A,
	titles B,
    titleauthor C,
    authors D
where A.TITLE_ID = B.TITLE_ID
	and B.TITLE_ID = C.TITLE_ID
    and C.AU_ID = D.AU_ID
group by D.AU_ID,
    D.au_lname,
	D.au_fname 
order by PROFIT DESC
LIMIT 3












