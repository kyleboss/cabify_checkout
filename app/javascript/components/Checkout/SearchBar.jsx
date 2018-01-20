import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from 'axios';

export default class SearchBar extends React.Component {
    constructor(props) {
        super(props);
        this.state = {queryValue: '', suggestions: [], quantity: 1};
    }

    fuzzySearch = function (userInput, productIdentifier) {
        let hay = productIdentifier.toLowerCase(), i = 0, n = -1, l;
        let s = userInput.toLowerCase();
        for (; l = s[i++];) if (!~(n = hay.indexOf(l, n + 1))) return false;
        return true;
    };

    autosuggest = function(text) {
        let suggestions = [];
        if (this.props.allProducts && text.length > 0) {
            let fuzzySearch = this.fuzzySearch;
            this.props.allProducts.forEach(function (product) {
                    if (fuzzySearch(text, product.title) || fuzzySearch(text, product.barcode_number)) {
                        if (!suggestions.some(suggestion => product.title === suggestion.title)) {
                            suggestions.push(product);
                        }
                    }
                }
            );
        }
        this.setState({suggestions: suggestions});
    };

    setValueToSuggestion = function (text) {
        this.setState({suggestions: [], queryValue: text});
        this.validateSearchBar(this.state.quantity, text);
    };

    onQueryChange = function (e) {
        let query = e.target.value;
        this.autosuggest(e.target.value);
        this.setState({queryValue: e.target.value});
        this.validateSearchBar(this.state.quantity, query);
    };

    validateSearchBar = function(quantity, query) {
        let searchBarError = undefined;
        if (isNaN(quantity)) {
            searchBarError = 'Quantity must be a number';
        } else if (quantity < 1) {
            searchBarError = 'Quantity must be at least 1';
        } else if (this.props.allProducts.findIndex(product => product.title === query || product.barcodeNumber === query) < 0) {
            searchBarError = 'Hmm...We are not able to find that product!';
        } else {
            this.setState({searchBarError: undefined});
        }
        this.setState({searchBarError: searchBarError});
        return !searchBarError;
    };

    onQuantityChange = function (e) {
        let quantity = e.target.value;
        this.setState({quantity: quantity});
        this.validateSearchBar(quantity, this.state.queryValue);
    };

    suggestionList = function() {
        return(this.state.suggestions.map((suggestion) =>
            <div
                className='autosuggestion'
                key={suggestion.barcode_number}
                onClick={(e) => this.setValueToSuggestion(suggestion.title)}
            >
                {suggestion.title}
            </div>
        ));
    };

    onScanSubmit = function(e) {
        this.setState({scanAttempted: true});
        if (this.validateSearchBar(this.state.quantity, this.state.queryValue)) {
            let isSuccess = this.props.onScanSubmit(this.state.queryValue, this.state.quantity);
            if (isSuccess) {
                this.setState({queryValue: '', quantity: 1});
                this.setState({scanAttempted: false});
            }
        }
    };

    showSearchError = function() {
        return this.state.searchBarError && this.state.scanAttempted;
    };

    render() {
        return (
            <div className='search-bar-container'>
                <div className='search-bar'>
                    <input
                        className='search-bar__query'
                        value={this.state.queryValue}
                        onChange={this.onQueryChange.bind(this)}
                        placeholder='Cabify TShirt...'
                    />
                    <input
                        className='search-bar__quantity'
                        value={this.state.quantity}
                        type='number'
                        onChange={this.onQuantityChange.bind(this)}
                    />
                    <button
                        className='search-bar__submit'
                        onClick={this.onScanSubmit.bind(this)}
                    >
                        ADD
                    </button>
                    <div className='autosuggestions'>{this.suggestionList()}</div>
                </div>
                <div className={`search-bar__error ${this.showSearchError() ? 'active-error' : ''}`}>
                    {this.state.searchBarError}
                </div>
            </div>
        );
    }
};