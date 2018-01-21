import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from "axios/index";
import ProductCard from "./ProductCard";

export default class Product extends React.Component {
    productCards = function() {
        return(this.props.allProducts.map((product) =>
            <ProductCard allCurrencies={this.props.allCurrencies} key={product.id} product={product} />
        ));
    };

    emptyProductCard = <ProductCard
        allCurrencies={this.props.allCurrencies}
        key={-1}
        product={{baseCurrency: 'EUR', numToBuy: 2, numWillGet: 1, bulkThreshold: 10, bulkPrice: '10.00', id: -1}}
    />;

    render() {
        return(
            <div className='products-container'>
                <h1 className='products-title'>Cabify Administration</h1>
                <div className='products-cards-container'>
                    {this.productCards()}
                    {this.emptyProductCard}
                </div>
            </div>
        );
    }
};