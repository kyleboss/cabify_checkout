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
        this.setState({suggestions: [], queryValue: text})
    };

    onQueryChange = function (e) {
        this.autosuggest(e.target.value);
        this.setState({queryValue: e.target.value});
    };

    onQuantityChange = function (e) {
        this.setState({quantity: e.target.value});
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
        let isSuccess = this.props.onScanSubmit(this.state.queryValue, this.state.quantity);
        if (isSuccess) {
            this.setState({queryValue: '', quantity: 1});
        }
    };

    render() {
        return (
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
        );
    }
};