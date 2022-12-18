def stock_picker(stock_prices)
    stock_info = stock_prices.map.with_index do |price, index|
        {day: index, price: price}
    end
    all_returns = stock_info.map.with_index do |price, index|
        stock_info[index..-1].reduce({}) do |max_return, current_day|
            price_diff = current_day[:price] - stock_info[index][:price]
            return_info = {buy_day: stock_info[index][:day], sell_day: current_day[:day], price_diff: price_diff}
            if (max_return.empty? || return_info[:price_diff] > max_return[:price_diff])
                return_info
            else
                max_return
            end
        end
    end
    best_day = all_returns.reduce do |max_return, current_day|
        if (max_return.empty? || current_day[:price_diff] > max_return[:price_diff])
            current_day
        else
            max_return
        end
    end
    [best_day[:buy_day], best_day[:sell_day]]
end

p stock_picker([17,3,6,9,15,8,6,1,10])
