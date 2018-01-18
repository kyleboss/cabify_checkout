import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Hero from "./hero";
import Cart from "./cart";

export default class Checkout extends React.Component {
    constructor(props) {
        super(props);
        this.state = {currency: this.currencies[0]};
    }

    currencies = [{code: 'eur', symbol: '€'}, {code: 'usd', symbol: '$'}, {code: 'gbp', symbol: '£'}];

    setCurrency(currency) {
        document.activeElement.blur();
        this.setState({
            currency: currency
        });
    }

    render() {
        return(
            <div className='checkout-container'>
                <Hero
                    currencies={this.currencies}
                    currency={this.state.currency}
                    onCurrencyChange={this.setCurrency.bind(this)}
                    allProducts={this.props.allProducts}
                />
                <Cart
                    currencySymbol={this.state.currency.symbol}
                    scannedProducts={this.props.scannedProducts}
                    discounts={this.props.discounts}
                />
            </div>
        );
    }
};

document.addEventListener('DOMContentLoaded', () => {
    ReactDOM.render(
        <Checkout />,
        document.body.appendChild(document.createElement('div')),
    )
});
