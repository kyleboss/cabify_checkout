import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Hero from "./Hero";
import Cart from "./Cart";
import axios from "axios/index";

export default class Checkout extends React.Component {
    constructor(props) {
        super(props);
        this.state = {currency: this.props.allCurrencies[0], searchBarError: '', isServerError: false};
    }

    setCurrency(currency) {
        document.activeElement.blur();
        let setCurrencyArgs = {currency: currency.code, authenticity_token: this.props.authenticityToken};
        let setCurrencyUrl;
        if (this.state.checkoutId) {
            setCurrencyUrl = `${this.props.baseUrl}/checkouts/${this.state.checkoutId}`;
            axios.put(setCurrencyUrl, setCurrencyArgs)
                .then((res) => this.updateCheckoutState(res, this))
                .catch((error) => {
                    this.setState({isServerError: true});
                    return false;
                });
        } else {
            setCurrencyUrl = `${this.props.baseUrl}/checkouts`;
            axios.post(setCurrencyUrl, setCurrencyArgs)
                .then((res) => this.updateCheckoutState(res, this))
                .catch((error) => {
                    this.setState({isServerError: true});
                    return false;
                });
        }
        return true;
    }

    updateCheckoutState = function(ajaxResults, obj) {
        if (ajaxResults.status >= 200 && ajaxResults.status < 300) {
            this.setState({isServerError: false});
            obj.setState({
                scannedProducts: ajaxResults.data.scanned_products,
                checkoutId: ajaxResults.data.checkout_id,
                cartSummary: ajaxResults.data.cart_summary,
                currency: ajaxResults.data.currency
            })
        } else {
            this.setState({isServerError: true});
        }
    };

    scan = function(query, quantity) {
        axios.post(`${this.props.baseUrl}/scans`, {
            checkout_id: this.state.checkoutId,
            product_identifier: query,
            quantity: quantity,
            authenticity_token: this.props.authenticityToken
        }).then((res) => this.updateCheckoutState(res, this))
            .catch((error) => {
                this.setState({isServerError: true});
                return false;
            });
        return true;
    };

    updateProductQuantity = function(scan_id, quantity) {
        axios.put(`${this.props.baseUrl}/scans/${scan_id}`, {
            quantity: quantity,
            authenticity_token: this.props.authenticityToken
        }).then((res) => this.updateCheckoutState(res, this))
            .catch((error) => {
                this.setState({isServerError: true});
                return false;
            });
        return true;
    };

    removeProduct = function(scan_id) {
        this.updateProductQuantity(scan_id, 0);
        return true;
    };

    checkout = function() {
        axios.post(`${this.props.baseUrl}/checkouts`, {
            currency: this.state.currency.code,
            authenticity_token: this.props.authenticityToken
        }).then((res) => this.updateCheckoutState(res, this))
            .catch((error) => {
                this.setState({isServerError: true});
                return false;
            });
        return true;
    };

    render() {
        return(
            <div className='checkout-container'>
                <div className={`server-error ${this.state.isServerError ? 'active-error' : ''}`}>
                    We are sorry, something went wrong! Please try again.
                </div>
                <Hero
                    allCurrencies={this.props.allCurrencies}
                    currency={this.state.currency}
                    searchBarError={this.state.searchBarError}
                    onCurrencyChange={this.setCurrency.bind(this)}
                    onScanSubmit={this.scan.bind(this)}
                    allProducts={this.props.allProducts}
                />
                <Cart
                    currencySymbol={this.state.currency.symbol}
                    cartSummary={this.state.cartSummary}
                    scannedProducts={this.state.scannedProducts}
                    updateProductQuantity={this.updateProductQuantity.bind(this)}
                    removeProduct={this.removeProduct.bind(this)}
                    checkout={this.checkout.bind(this)}
                />
            </div>
        );
    }
};