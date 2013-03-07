class AttachmentDecorator < ApplicationDecorator
  delegate_all

  def link_to_filename
    h.link_to filename, source.file.url
  end

  def filename
    h.truncate(File.basename(source.file.url), length: 15) + '.' + File.extname(source.file.url)
  end

end
