import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Hero from "./Hero";
import Cart from "./Cart";
import axios from "axios/index";

export default class Checkout extends React.Component {
    constructor(props) {
        super(props);
        this.state = {currency: this.props.allCurrencies[0]};
    }

    setCurrency(currency) {
        document.activeElement.blur();
        let setCurrencyArgs = {currency: currency.code, authenticity_token: this.props.authenticityToken};
        let setCurrencyUrl;
        if (this.state.checkoutId) {
            setCurrencyUrl = `${this.props.baseUrl}/checkouts/${this.state.checkoutId}`;
            axios.put(setCurrencyUrl, setCurrencyArgs).then((res) => this.updateCheckoutState(res, this));
        } else {
            setCurrencyUrl = `${this.props.baseUrl}/checkouts`;
            axios.post(setCurrencyUrl, setCurrencyArgs).then((res) => this.updateCheckoutState(res, this));
        }
        return true;
    }

    updateCheckoutState = function(ajaxResults, obj) {
        obj.setState({
            scannedProducts: ajaxResults.data.scanned_products,
            checkoutId: ajaxResults.data.checkout_id,
            cartSummary: ajaxResults.data.cart_summary,
            currency: ajaxResults.data.currency
        })
    };

    scan = function(query, quantity) {
        axios.post(`${this.props.baseUrl}/scans`, {
            checkout_id: this.state.checkoutId,
            product_identifier: query,
            quantity: quantity,
            authenticity_token: this.props.authenticityToken
        }).then((res) => this.updateCheckoutState(res, this));
        return true;
    };

    render() {
        return(
            <div className='checkout-container'>
                <Hero
                    allCurrencies={this.props.allCurrencies}
                    currency={this.state.currency}
                    onCurrencyChange={this.setCurrency.bind(this)}
                    onScanSubmit={this.scan.bind(this)}
                    allProducts={this.props.allProducts}
                />
                <Cart
                    currencySymbol={this.state.currency.symbol}
                    cartSummary={this.state.cartSummary}
                    scannedProducts={this.state.scannedProducts}
                />
            </div>
        );
    }
};