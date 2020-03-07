class TransactionsController < ApplicationController
    
    skip_before_action :verify_authenticity_token

    def create
        transaction = Transaction.new(transactionParams)
        if transaction.save
            render json: transaction
        else
            render json: 'error'
        end
    end

    def index
        user = User.find(params[:user_id])
        transactions = Transaction.select{|transaction| transaction.user_id === user.id}
        render json: transactions
    end

    def show
        transaction = Transaction.find(params[:id])
        render json: transaction
    end

    private

        def transactionParams
            params.require(:transaction).permit(:ticker, :shares, :cost_purchased, :user_id)
        end

end
