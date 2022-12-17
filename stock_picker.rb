def stock_picker(stock_prices)
    # for each number, get the index max price day after it, and
    # the difference between that day and the current day
    # store these in a hash ({0 => {index: ni}, 1 => 4, ...})

    best_days = stock_prices.map.with_index do |price, index|
        best_day = stock_prices[index..-1].reduce({}) do |max_return, current_price|
            price_diff = current_price - price
            if max_return.empty?
                max_return = {price: current_price, diff: price_diff}
            end
            if (price_diff > max_return[:diff])
                {price: current_price, diff: price_diff}
            else
                max_return
            end
        end
        best_day
    end
    best_days = best_days.map.with_index do |value, index|
        value[:buy_day] = index
        value
    end
    best_days.reduce do |best_max_return, current_return|
        if (current_return[:diff] > best_max_return[:diff])
            current_return
        else
            best_max_return
        end
    end
end

puts stock_picker([17,3,6,9,15,8,6,1,10])
