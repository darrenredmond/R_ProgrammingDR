source(file.path(path.package('swirl'), 'Courses', 'R_ProgrammingDR', 'basis.R'))

dbs_on_demand <- function() {
  return(submit_dbs_on_demand('r_basic_building_blocks'))
}
