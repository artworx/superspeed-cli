module SuperspeedCli
  class Log
    include Virtus.model

    DATE_FORMAT = '%d-%m-%Y'

    attribute :date, Date, default: Date.today
    attribute :task, String, default: 'bot'
    attribute :task_id, Integer
    attribute :description, String
    attribute :billingcode, Integer, default: 0
    attribute :hours, Integer, default: 8

    attr_accessor :date, :task, :description, :billingcode, :hours

    def to_json
      JSON.generate({
        startDate: date.strftime(DATE_FORMAT),
        endDate: date.strftime(DATE_FORMAT),
        task: task,
        taskId: task_id,
        description: description,
        billingcode: billingcode,
        hours: hours
      })
    end
  end
end
