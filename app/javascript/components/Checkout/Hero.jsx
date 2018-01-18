import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import SearchBar from "./SearchBar";
import CurrencySelector from "./CurrencySelector";

export default class Hero extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return(
            <div className='hero'>
                <SearchBar allProducts={this.props.allProducts} />
                <CurrencySelector
                    currencies={this.props.currencies}
                    currency={this.props.currency}
                    onCurrencyChange={this.props.onCurrencyChange}
                />
            </div>
        );
    };
};