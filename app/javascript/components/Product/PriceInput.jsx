import React from "react";

export default class PriceInput extends React.Component {

    currencyOptions = function() {
        return(this.props.allCurrencies.map((currency) =>
            <option key={currency.code} value={currency.code}>{currency.symbol}</option>
        ));
    };

    currentCurrencySymbol = function() {
        return(this.props.allCurrencies[this.props.allCurrencies.findIndex(c =>
            c.code === this.props.baseCurrency.toLowerCase()
        )].symbol);
    };

    render() {
        return(
            <div className='price-input__container'>
                {this.props.createInputSet('Price', '8.99...', 'basePrice', 'base-price', 'number')}
                <div className='price-input__currency-set'>
                    <div className='price-input__currency-label'>Currency</div>
                    <select
                        className='price-input__input price-input__base-currency'
                        defaultValue={this.currentCurrencySymbol()}
                        onChange={(e) => this.props.updateProductProperty(e, 'baseCurrency')}
                    >
                        {this.currencyOptions()}
                    </select>
                </div>
            </div>
        );
    };
};