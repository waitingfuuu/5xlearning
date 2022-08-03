# frozen_string_literal: true

module TaskHelper
  def split_tag(task)
    delimiters = [' ', ',', '，', '、', ';', '；']
    tag_str = task.tag.gsub(' ', '')
    tag_str.split(Regexp.union(delimiters))
  end
end
