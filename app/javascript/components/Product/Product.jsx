import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import axios from "axios/index";
import ProductCard from "./ProductCard";

export default class Product extends React.Component {
    constructor(props) {
        super(props);
        this.state = {isServerError: false, allProducts: this.sanitizeProducts(this.props.allProducts)};
    }

    sanitizeProducts = function(allProducts) {
        allProducts = allProducts.map((product) => {
            let bulk_price = product.bulk_price;
            product.numToBuy = product.num_to_buy || 2;
            product.numWillGet = product.num_will_get || 1;
            product.basePrice = parseFloat(product.base_price).toFixed(2);
            product.baseCurrency = product.base_currency;
            product.imageUrl = product.image_url || defaultImageUrl;
            product.bulkPrice = isNaN(bulk_price) ? product.basePrice : parseFloat(bulk_price).toFixed(2);
            product.bulkThreshold = product.bulk_threshold || 10;
            product.barcodeNumber = product.barcode_number;
            product.barcode_number = undefined;
            product.num_will_get = undefined;
            product.base_price = undefined;
            product.num_to_buy = undefined;
            product.bulk_price = undefined;
            product.bulk_threshold = undefined;
            return(product);
        });
        allProducts.push(this.emptyProduct());
        return allProducts;
    };

    productCards = function() {
        if (this.state.allProducts) {
            return (this.state.allProducts.map((product) =>
                <ProductCard
                    allCurrencies={this.props.allCurrencies}
                    key={product.id}
                    product={product}
                    saveProduct={this.saveProduct.bind(this)}
                    removeProduct={this.removeProduct.bind(this)}
                />
            ));
        }
    };

    argsFromProduct = function(product, isRemoval = false) {
        return {
            title: product.title,
            image_url: product.imageUrl,
            barcode_number: product.barcodeNumber,
            base_price: product.basePrice,
            base_currency: product.baseCurrency,
            type: product.type || 'Product',
            bulk_threshold: ((product.type === 'BulkProduct' && product.bulkThreshold) || undefined),
            bulk_price: ((product.type === 'BulkProduct' && product.bulkPrice) || undefined),
            num_to_buy: ((product.type === 'BuyXGetXProduct' && product.numToBuy) || undefined),
            num_will_get: ((product.type === 'BuyXGetXProduct' && product.numWillGet) || undefined),
            is_removal: isRemoval,
            authenticity_token: this.props.authenticityToken
        };
    };

    updateProductState = function(ajaxResults) {
        this.setState({allProducts: []});
        if (ajaxResults.status >= 200 && ajaxResults.status < 300) {
            this.setState({ allProducts: this.sanitizeProducts(ajaxResults.data), isServerError: false });
        } else {
            this.setState({isServerError: true});
        }
    };

    saveProduct = function(product, isRemoval = false) {
        if (product.id === -1 ) {
            axios.post(`${this.props.baseUrl}/products`, this.argsFromProduct(product))
                .then(this.updateProductState.bind(this))
                .catch((error) => {
                    this.setState({isServerError: true});
                    return false;
                });
        } else {
            axios.put(`${this.props.baseUrl}/products/${product.id}`, this.argsFromProduct(product, isRemoval))
                .then(this.updateProductState.bind(this))
                .catch((error) => {
                    this.setState({isServerError: true});
                    return false;
                });
        }
        return true;
    };

    removeProduct = function(product_id) {
        this.saveProduct({id: product_id}, true)
    };

    emptyProduct = function() {
        return({
            baseCurrency: 'EUR',
            numToBuy: 2,
            numWillGet: 1,
            bulkThreshold: 10,
            bulkPrice: '10.00',
            id: -1,
            imageUrl: 'https://s3-us-west-2.amazonaws.com/kyleboss.com/cabify/cart.png',
        });
    };

    render() {
        return(
            <div className='products-container'>
                <div className={`products-error ${this.state.isServerError ? 'active-error' : ''}`}>
                    Something went wrong! Please try again
                </div>
                <h1 className='products-title'>Cabify Administration</h1>
                <div className='products-cards-container'>
                    {this.productCards()}
                </div>
            </div>
        );
    }
};