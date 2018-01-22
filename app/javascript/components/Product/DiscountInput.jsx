import React from "react";
import InputSet from "./InputSet";

export default class DiscountInput extends React.Component {
    constructor(props) {
        super(props);
        this.state = {product: this.props.product};
    }

    createInputSet = function(label, placeholder, propertyName, type = 'text') {
      return(<InputSet
          containerClass='discounts__input-container'
          labelClass='discounts__input-label'
          inputClass='discounts__input discounts__input-text'
          label={label}
          placeholder={placeholder}
          propertyName={propertyName}
          value={this.props.product[propertyName]}
          type={type}
          errorClass='discounts__error'
          errorValue={this.props.errors[propertyName]}
          updateProductProperty={this.props.updateProductProperty}
      />)
    };

    firstInput = function() {
        return(
            <div>
                {this.props.product.type === 'BuyXGetXProduct' &&
                this.createInputSet('Buy', '5...', 'numToBuy', 'number')}
                {this.props.product.type === 'BulkProduct' &&
                this.createInputSet('Threshold', '5...', 'bulkThreshold', 'number')}
            </div>
        );
    };

    secondInput = function() {
        return(
            <div>
                {this.props.product.type === 'BuyXGetXProduct' &&
                this.createInputSet('Get', '3...', 'numWillGet', 'number')}
                {this.props.product.type === 'BulkProduct' &&
                this.createInputSet('Bulk price', '1.99...', 'bulkPrice', 'number')}
            </div>

        );
    };

    allDiscountTypes = [
        { value: 'Product', label: 'Product' },
        { value: 'BuyXGetXProduct', label: 'Buy X Get Y Free' },
        { value: 'BulkProduct', label: 'Bulk Pricing' },
    ];

    discountTypes = function() {
        return(this.allDiscountTypes.map((discountType) =>
            <option key={discountType.value} value={discountType.value}>{discountType.label}</option>
        ));
    };

    render() {
        return(
            <div className='discounts'>
                <div className='discounts__selector'>
                    <div className='discounts__input-container'>
                        <div className='discounts__input-label'>Discount type</div>
                        <select
                            onChange={(e) => this.props.updateProductProperty(e, 'type')}
                            className='discounts__input discounts__type-selector'
                            defaultValue={this.props.product.type}
                        >
                            {this.discountTypes()}
                        </select>
                    </div>
                </div>
                {(this.props.product.type === 'BuyXGetXProduct' || this.props.product.type === 'BulkProduct') &&
                <div className='discounts__inputs'>
                    {this.firstInput()}
                    {this.secondInput()}
                </div>
                }
            </div>
        );
    };
};