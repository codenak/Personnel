# replace company values with their trimmed values
update layoffs3
set company = trim(company);

#removal of error values in country field
update layoffs3
set country = 'United States'
where country = 'United States.';

#removal of error values in industry field
update layoffs3
set industry = 'Crypto'
where industry like 'Crypto%';

#removal of blanks in industry field
update layoffs3 t1
join layoffs3 t2 on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry = '' and t2.industry != '';

#changing date writing format first, then changing datatype to date
update layoffs3
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs3
modify column `date` date;

#deleting rows where both total_laid_off and percentage_laid_off are null
delete from layoffs3
where total_laid_off is null and percentage_laid_off is null;

#finally drop the row_id column, we don't need that anymore!
alter table layoffs3
drop column row_id;

select * from layoffs3;