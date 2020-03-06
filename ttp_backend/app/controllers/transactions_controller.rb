class TransactionsController < ApplicationController
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

    def update
        transaction = Transaction.find(params[:id])
        transaction.update(transactionParams)
    end

    def destroy
        transaction = Transaction.find(params[:id])
        transaction.destroy
    end

    private

        def transactionParams
            params.require(:transaction).permit(:ticker, :shares, :cost_purchased, :user_id)
        end

end
