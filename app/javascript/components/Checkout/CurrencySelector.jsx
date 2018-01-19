import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

export default class CurrencySelector extends React.Component {
    currencyListItems = this.props.allCurrencies.map((currency) =>
            <li
                className='dropdown-item'
                key={currency.code}
                onClick={() => this.props.onCurrencyChange(currency)}
            >
                <div className='dropdown-item__text'>
                    <div className='dropdown-item__code'>{currency.code}</div>
                    <div>{currency.symbol}</div>
                </div>
            </li>
        );

    render() {
        return (
            <div className='dropdown-button'>
                <button className="btn"><span>{this.props.currency.code}</span>{this.props.currency.symbol}
                    <ul className="dropdown">{this.currencyListItems}</ul>
                </button>
            </div>
        );
    }
};