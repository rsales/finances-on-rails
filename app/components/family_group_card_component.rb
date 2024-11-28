# frozen_string_literal: true

class FamilyGroupCardComponent < ViewComponent::Base
  attr_reader :family_group

  def initialize(family_group:)
    @family_group = family_group
  end
end
