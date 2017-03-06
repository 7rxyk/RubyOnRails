class MembershipConfirmationsController < ApplicationController
  before_action :set_membership_confirmation, only: [:show, :edit, :update, :destroy, :confirm]

  # GET /membership_confirmations
  # GET /membership_confirmations.json
  def index
    @membership_confirmations = MembershipConfirmation.all
  end

  # GET /membership_confirmations/1
  # GET /membership_confirmations/1.json
  def show
  end

  # GET /membership_confirmations/new
  def new
    @membership_confirmation = MembershipConfirmation.new
  end

  # GET /membership_confirmations/1/edit
  def edit
  end

  # POST /membership_confirmations
  # POST /membership_confirmations.json
  def create
    @membership_confirmation = MembershipConfirmation.new(membership_confirmation_params)
    @membership_confirmation.user = current_user

    respond_to do |format|
      if @membership_confirmation.save
        format.html { redirect_to :back, notice: 'Your application has been received.' }
        format.json { render :show, status: :created, location: @membership_confirmation }
      else
        format.html { redirect_to :back, notice: 'You already have a pending application' }
      end
    end
  end

  # PATCH/PUT /membership_confirmations/1
  # PATCH/PUT /membership_confirmations/1.json
  def update
    respond_to do |format|
      if @membership_confirmation.update(membership_confirmation_params)
        format.html { redirect_to @membership_confirmation, notice: 'Membership confirmation was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership_confirmation }
      else
        format.html { render :edit }
        format.json { render json: @membership_confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /membership_confirmations/1
  # DELETE /membership_confirmations/1.json
  def destroy
    @membership_confirmation.destroy
    respond_to do |format|
      format.html { redirect_to membership_confirmations_url, notice: 'Membership confirmation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    byebug
    beerclub = @membership_confirmation.beer_club
    if beerclub.members.include? current_user
      membership = Membership.new
      membership.beer_club = beerclub;
      membership.user = @membership_confirmation.user
      if membership.save
        redirect_to :back, notice: "Application confirmed"
        @membership_confirmation.destroy
      else
        redirect_to :back, notice: "Error confirming"
      end
    else
      redirect_to :back, notice: "Only members can confirm memberships"
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership_confirmation
      @membership_confirmation = MembershipConfirmation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_confirmation_params
      params.require(:membership_confirmation).permit(:user_id, :beer_club_id)
    end
end
