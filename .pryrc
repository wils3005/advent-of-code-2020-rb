# frozen_string_literal: true

Dir.glob(File.join("#{__dir__}/*.rb")).each(&method(:require))
