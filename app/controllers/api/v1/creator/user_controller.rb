# frozen_string_literal: true

class Api::V1::Creator::UserController < ApplicationController
  def index
    render json: User.basic.actived.pluck(:email)
  end

  def send_email
    send_from = "#{mail_params[:send_from]} <#{@current_user.email}>"
    title = mail_params[:title]
    content = mail_params[:content]
    EventMailer.notificate(mail_params[:emails_address], title, content, send_from).deliver_later

    head :ok
  end

  private
    def mail_params
      params.require(:email)
            .permit(
              :send_from,
              :title,
              :content,
              :emails_address
            )
    end
end
