-- Getting a view of the data

select * from CENSUS_DATA;
select * from CHICAGO_CRIME_DATA;
select * from CHICAGO_PUBLIC_SCHOOLS;
select * from CHICAGO_SOCIOECONOMIC_DATA;

-- Select
select COMMUNITY_AREA_NAME from CENSUS_DATA;

-- Select + Where
select COMMUNITY_AREA_NAME from CENSUS_DATA where HARDSHIP_INDEX > 50;

-- Select + Where + Group By
select count(*) as Total_Thefts, COMMUNITY_AREA_NUMBER from CHICAGO_CRIME_DATA where PRIMARY_TYPE = 'THEFT'
group by COMMUNITY_AREA_NUMBER;

-- Select + Where + Group By + Order By
select count(*) as Total_Thefts, COMMUNITY_AREA_NUMBER from CHICAGO_CRIME_DATA where PRIMARY_TYPE = 'THEFT'
group by COMMUNITY_AREA_NUMBER order by Total_Thefts DESC;

-- Select + Where + Group By + Having + Order by
select count(*) as Total_Thefts, COMMUNITY_AREA_NUMBER from CHICAGO_CRIME_DATA where PRIMARY_TYPE = 'THEFT'
group by COMMUNITY_AREA_NUMBER having count(*) > 3 order by Total_Thefts DESC;

-- Max, Min, Average
select max(PERCENT_HOUSEHOLDS_BELOW_POVERTY) from CHICAGO_SOCIOECONOMIC_DATA;
select min(PERCENT_OF_HOUSING_CROWDED) from CHICAGO_SOCIOECONOMIC_DATA;
select avg(PERCENT_AGED_25_WITHOUT_HIGH_SCHOOL_DIPLOMA) from CHICAGO_SOCIOECONOMIC_DATA;

select PERCENT_HOUSEHOLDS_BELOW_POVERTY, COMMUNITY_AREA_NAME from CHICAGO_SOCIOECONOMIC_DATA
order by PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC LIMIT 1;

select PERCENT_OF_HOUSING_CROWDED, COMMUNITY_AREA_NAME from CHICAGO_SOCIOECONOMIC_DATA
order by PERCENT_OF_HOUSING_CROWDED LIMIT 1;

-- Inner Join: Displaying primary type of crime and community area name for crimes that happened after 2010
select cr.PRIMARY_TYPE, cr.DATE, cd.COMMUNITY_AREA_NAME from CHICAGO_CRIME_DATA cr
inner join CENSUS_DATA cd on cr.COMMUNITY_AREA_NUMBER = cd.COMMUNITY_AREA_NUMBER where YEAR(date) > 2010;

-- Left Join: Displaying the names of all schools, the average student attendance, and average teacher attendance -
-- But only the hardship indexes that are less than or equal to 50. Ordering by student attendance.
select ps.NAME_OF_SCHOOL, ps.AVERAGE_STUDENT_ATTENDANCE, ps.AVERAGE_TEACHER_ATTENDANCE, cd.hardship_index
from CHICAGO_PUBLIC_SCHOOLS ps left join CENSUS_DATA cd on ps.COMMUNITY_AREA_NUMBER = cd.COMMUNITY_AREA_NUMBER 
and cd.hardship_index <= 50 order by ps.AVERAGE_STUDENT_ATTENDANCE;

-- Right Join: Displaying all school names, percent exceeding at math, and percent exceeding at reading -
-- But only the percent households below poverty for those greater than or equal to 25 percent.
select ps.NAME_OF_SCHOOL, ps.ISAT_EXCEEDING_MATH__, ps.ISAT_EXCEEDING_READING__, cd.PERCENT_HOUSEHOLDS_BELOW_POVERTY
from CENSUS_DATA cd right join CHICAGO_PUBLIC_SCHOOLS ps on cd.COMMUNITY_AREA_NUMBER = ps.COMMUNITY_AREA_NUMBER
and cd.PERCENT_HOUSEHOLDS_BELOW_POVERTY >= 25 order by cd.PERCENT_HOUSEHOLDS_BELOW_POVERTY;

-- Full Join
select cd.COMMUNITY_AREA_NAME, ps.NAME_OF_SCHOOL, ps.SAFETY_SCORE, ps.FAMILY_INVOLVEMENT_SCORE, ps.ENVIRONMENT_SCORE
from CHICAGO_PUBLIC_SCHOOLS ps full join CENSUS_DATA cd on ps.COMMUNITY_AREA_NUMBER = cd.COMMUNITY_AREA_NUMBER
order by cd.COMMUNITY_AREA_NAME;