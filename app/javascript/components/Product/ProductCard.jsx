import React from "react";
import DiscountInput from "./DiscountInput";
import ActionButtons from "./ActionButtons";
import InputSet from "./InputSet";

export default class ProductCard extends React.Component {
    constructor(props) {
        super(props);
        this.state = {product: this.props.product};
    }

    updateProductProperty = function(e, propertyName) {
        console.log(`updating ${propertyName} to ${e.target.value}`);
        let product = this.state.product;
        product[propertyName] = e.target.value;
        this.setState({product: product});
    };

    currencyOptions = function() {
        return(this.props.allCurrencies.map((currency) =>
            <option value={currency.code}>{currency.symbol}</option>
    ));
    };

    currentCurrencySymbol = function() {
        return(this.props.allCurrencies[this.props.allCurrencies.findIndex(c =>
            c.code === this.props.product.baseCurrency.toLowerCase()
        )].symbol);
    };

    render() {
        return(
            <div className='product-card'>
                <InputSet
                    inputClass='title'
                    label='Title'
                    placeholder='T-Shirt...'
                    propertyName='title'
                    value={this.state.product.title}
                />
                <img className='product-card__image' src={this.state.product.imageUrl} />
                <InputSet
                    inputClass='image-url'
                    label='Image URL'
                    placeholder='http://www....'
                    propertyName='imageUrl'
                    value={this.state.product.imageUrl}
                />
                <div className='product-card__input-price'>
                    <InputSet
                        inputClass='base-price'
                        label='Price'
                        placeholder='8.99...'
                        propertyName='basePrice'
                        value={this.state.product.basePrice}
                    />
                    <div className='product-card__input-container'>
                        <div className='product-card__input-label'>Currency</div>
                        <select
                            className='product-card__input product-card__base-currency'
                            defaultValue={this.currentCurrencySymbol()}
                            onChange={(e) => this.updateProductProperty(e, 'baseCurrency')}
                        >
                            {this.currencyOptions()}
                        </select>
                    </div>
                </div>
                <DiscountInput
                    product={this.state.product}
                    updateProductProperty={this.updateProductProperty.bind(this)}
                />
                <ActionButtons
                    saveProduct={this.props.saveProduct}
                    removeProduct={this.props.removeProduct}
                    product={this.state.product}
                />
            </div>
        );
    };
};