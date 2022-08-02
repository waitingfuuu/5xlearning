# frozen_string_literal: true

module TaskHelper
  def split_tag(task)
    delimiters = [' ', ',', '，', '、', ';', '；']
    task.tag.split(Regexp.union(delimiters))
  end
end
