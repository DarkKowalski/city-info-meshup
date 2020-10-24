# frozen_string_literal: true

ROOT_ROUTE = proc do
  get '' do
    Gyoku.xml({ status: 'running' })
  end
end
