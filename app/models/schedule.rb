class Schedule < ActiveRecord::Base

  belongs_to :cultivar
  belongs_to :producer, class_name: "User"

  def self.sql_sum(date, cultivar_id = nil)
  	
  	tbl = Schedule.arel_table
  	conditions = tbl[:date].eq(date)
    conditions = conditions.and(tbl[:cultivar_id].eq(cultivar_id)) if cultivar_id

  	schedules = Arel::Table.new :schedules
  	schedules.where(conditions).group(schedules[:cultivar_id]).project(
  		schedules[:amount].sum.as('sum'),
  		schedules[:cultivar_id]
  	).to_sql

  end

  def self.sql_mysum(date, producer_id)
    return if producer_id.blank?
    
    tbl = Schedule.arel_table
    conditions = tbl[:date].eq(date).and(tbl[:producer_id].eq(producer_id))

    schedules = Arel::Table.new :schedules
    schedules.where(conditions).group(schedules[:cultivar_id]).project(
      schedules[:amount].sum.as('sum'),
      schedules[:cultivar_id]
    ).to_sql
  end

  def self.display_cultivar(date, producer_id)
    tbl = Schedule.arel_table
    conditions = tbl[:date].eq(date).and(tbl[:producer_id].eq(producer_id))
    Schedule.joins(:cultivar).where(conditions)
  end

end
