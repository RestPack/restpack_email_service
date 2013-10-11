require 'spec_helper'

describe Commands::Email::Send do
  is_required :application_id, :from, :to, :subject, :text_body
  is_optional :cc, :bcc, :reply_to, :html_body

  pending 'TODO: add some specs'
end
