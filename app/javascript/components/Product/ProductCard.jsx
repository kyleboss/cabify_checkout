import React from "react";
import DiscountInput from "./DiscountInput";

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
                <div className='product-card__input-container'>
                    <div className='product-card__input-label'>Title</div>
                    <input
                        className='product-card__input product-card__title'
                        placeholder='Product title'
                        onChange={(e) => this.updateProductProperty(e, 'title')}
                        value={this.state.product.title}
                    />
                </div>
                <img className='product-card__image' src={this.state.product.image_url} />
                <div className='product-card__input-container'>
                    <div className='product-card__input-label'>Image URL</div>
                    <input
                        className='product-card__input product-card__image-url'
                        placeholder='Image URL'
                        onChange={(e) => this.updateProductProperty(e, 'imageUrl')}
                        value={this.state.product.image_url}
                    />
                </div>
                <div className='product-card__input-price'>
                    <div className='product-card__input-container'>
                        <div className='product-card__input-label'>Price</div>
                        <input
                            className='product-card__input product-card__base-price'
                            placeholder='Price'
                            onChange={(e) => this.updateProductProperty(e, 'basePrice')}
                            value={this.state.product.basePrice}
                        />
                    </div>
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
                <div className='product-card__action-buttons'>
                    <button
                        className='product-card__save-button'
                        onChange={(e) => this.props.saveProduct(this.state.product)}
                    >
                        Save
                    </button>
                    <button
                        onClick={(e) => this.props.removeProduct(this.state.product.id)}
                        className='product-card__remove-button'
                    >
                        Remove
                    </button>
                </div>
            </div>
        );
    };
};