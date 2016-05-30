class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :categories
  has_many :expenses, :through => :categories
  validates :name, :limit, :start_date, :end_date, :categories, presence: true
  validate :end_cannot_come_before_start
  validates :limit, numericality: true
  scope :active, -> { where("start_date <= ? AND end_date > ?", Date.current, Date.current) }
  scope :inactive, -> { where("start_date > ?", Date.current) }
  scope :completed, -> { where("end_date <= ?", Date.current) }
  accepts_nested_attributes_for :categories, :reject_if => proc { |attributes| attributes[:title].blank? }

  def remaining_expense
    self.limit - self.total_expense
  end

  def exceeded?
    self.total_expense > self.limit
  end

  def average_expenditure
    Date.current > self.start_date ? self.total_expense / (Date.current - self.start_date).to_i : "Unknown"
  end

  def recommended_expenditure
    self.remaining_expense/self.remaining_days
  end

  def remaining_days
    (self.end_date - self.start_date).to_i
  end

  def status
    if self.start_date > Date.current
      "Inactive"
    elsif self.end_date <= Date.current
      "Completed"
    else
      "Active"
    end
  end

  private

  def end_cannot_come_before_start
    unless self.end_date == nil or self.start_date == nil
      errors.add(:end_date, "cannot come before start date") if self.end_date < self.start_date
    end
  end

end
