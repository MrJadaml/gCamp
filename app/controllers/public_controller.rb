class PublicController < ApplicationController
skip_before_action :ensure_logged_in, :members_only


end
