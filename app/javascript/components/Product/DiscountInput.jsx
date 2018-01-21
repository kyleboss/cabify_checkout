import React from "react";
import InputSet from "./InputSet";

export default class DiscountInput extends React.Component {
    defaultInputClasses = {
        container: 'discounts__input-container',
        label: 'discounts__input-label',
        input: 'discounts__input discounts__input-text'
    };

    firstInput = function() {
        return(
            <div>
            {this.props.product.type === 'BuyXGetXProduct' &&
                <InputSet
                    containerClass={this.defaultInputClasses.container}
                    labelClass={this.defaultInputClasses.label}
                    inputClass={this.defaultInputClasses.input}
                    label='Buy'
                    placeholder='5...'
                    propertyName='numToBuy'
                    value={this.props.product.numToBuy}
                    type='number'
                />
                }
                {this.props.product.type === 'BulkProduct' &&
                    <InputSet
                        containerClass={this.defaultInputClasses.container}
                        labelClass={this.defaultInputClasses.label}
                        inputClass={this.defaultInputClasses.input}
                        label='Threshold'
                        placeholder='5...'
                        propertyName='bulkThreshold'
                        value={this.props.product.bulkThreshold}
                        type='number'
                    />
                }
            </div>
        );
    };

    secondInput = function() {
        return(
            <div>
                {this.props.product.type === 'BuyXGetXProduct' &&
                    <InputSet
                        containerClass={this.defaultInputClasses.container}
                        labelClass={this.defaultInputClasses.label}
                        inputClass={this.defaultInputClasses.input}
                        label='Get'
                        placeholder='3...'
                        propertyName='numWillGet'
                        value={this.props.product.numWillGet}
                        type='number'
                    />
                }
                {this.props.product.type === 'BulkProduct' &&
                    <InputSet
                        containerClass={this.defaultInputClasses.container}
                        labelClass={this.defaultInputClasses.label}
                        inputClass={this.defaultInputClasses.input}
                        label='Bulk price'
                        placeholder='1.99...'
                        propertyName='bulkPrice'
                        value={this.props.product.bulkPrice}
                    />
                }
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