import React from "react";
import DiscountInput from "./DiscountInput";
import ActionButtons from "./ActionButtons";
import InputSet from "./InputSet";
import PriceInput from "./PriceInput";

export default class ProductCard extends React.Component {
    constructor(props) {
        super(props);
        this.state = {product: this.props.product, errors: {}, submissionAttempted: false};
    }

    updateProductProperty = function(e, propertyName) {
        let product = this.state.product;
        product[propertyName] = e.target.value;
        if (this.state.submissionAttempted) { this.validateInputs() }
        this.setState({product: product});
    };

    saveProduct = function() {
        let errors = this.validateInputs();
        if (Object.keys(errors).length === 0) {
            this.props.saveProduct(this.state.product);
            this.setState({submissionAttempted: false});
        } else {
            this.setState({submissionAttempted: true});
        }
    };

    createInputSet = function(label, placeholder, propertyName, inputClass, type = 'text') {
        return(<InputSet
            containerClass='product-card__input-container'
            labelClass='product-card__input-label'
            inputClass={`product-card__input product-card__${inputClass}`}
            label={label}
            placeholder={placeholder}
            propertyName={propertyName}
            value={this.state.product[propertyName] || ''}
            errorClass='product-card__error'
            errorValue={this.state.errors[propertyName]}
            updateProductProperty={this.updateProductProperty.bind(this)}
            type={type}
        />)
    };

    validateNumeric = function(errorProp, productProp, numberType) {
        if (!productProp) { errorProp = 'Enter a positive number' }
        else if (numberType === 'int' && isNaN(productProp)) { errorProp = 'Enter an integer' }
        else if (numberType === 'float' && isNaN(productProp)) { errorProp = 'Enter a number' }
        else if (numberType === 'int' && parseInt(productProp) <= 0) { errorProp = 'Integer must be positive'; }
        else if (numberType === 'float' && parseFloat(productProp) <= 0) { errorProp = 'Number must be positive'; }
        return errorProp;
    };

    validateInputs = function() {
        let product = this.state.product;
        let errors = {};
        if (!product.title || product.title.length === 0) { errors.title = 'Enter a product name' }
        if (!product.barcodeNumber || product.barcodeNumber.length === 0) {
            errors.barcodeNumber = 'Enter a barcode identifier'
        }
        errors.basePrice = this.validateNumeric(errors.basePrice, product.basePrice, 'float');
        if (product.type === 'BulkProduct') {
            errors.bulkThreshold = this.validateNumeric(errors.bulkThreshold, product.bulkThreshold, 'int');
            errors.bulkPrice = this.validateNumeric(errors.bulkPrice, product.bulkPrice, 'float');
        }
        else if (product.type === 'BuyXGetXProduct') {
            errors.numToBuy = this.validateNumeric(errors.numToBuy, product.numToBuy, 'int');
            errors.numWillGet = this.validateNumeric(errors.numWillGet, product.numWillGet, 'int');
            if (!errors.numToBuy && product.numToBuy <= product.numWillGet) {
                errors.numToBuy = '#-to-buy must be greater than #-will-get'
            }
        }
        Object.keys(errors).forEach((key) => (errors[key] == null) && delete errors[key]);
        this.setState({errors: errors});
        return errors;
    };

    render() {
        return(
            <div className='product-card'>
                {this.createInputSet('Title', 'T-Shirt...', 'title', 'title')}
                <img className='product-card__image' src={this.state.product.imageUrl} />
                {this.createInputSet('Image URL', 'http://...', 'imageUrl', 'image-url')}
                {this.createInputSet('Barcode Identifier', '341299907...', 'barcodeNumber', 'barcode-number')}
                <PriceInput
                    allCurrencies={this.props.allCurrencies}
                    createInputSet={this.createInputSet.bind(this)}
                    baseCurrency={this.state.product.baseCurrency}
                    basePrice={this.state.product.basePrice}
                    updateProductProperty={this.updateProductProperty.bind(this)}
                />
                <DiscountInput
                    product={this.state.product}
                    updateProductProperty={this.updateProductProperty.bind(this)}
                    errors={this.state.errors}
                />
                <ActionButtons
                    saveProduct={this.saveProduct.bind(this)}
                    removeProduct={this.props.removeProduct}
                    product={this.state.product}
                />
            </div>
        );
    };
};