# frozen_string_literal: true

class SidebarComponent < ViewComponent::Base
  include Rails.application.routes.url_helpers

  # Atributos que irão controlar os modos
  attr_reader :user, :family_group

  # Inicializa o componente com o usuário e o family_group
  def initialize(current_user:, family_group: nil)
    @current_user = current_user
    @family_group = family_group
  end

  # Verifica se o usuário tem um family_group
  def show_dashboard_mode?
    @family_group.present?
  end
end
