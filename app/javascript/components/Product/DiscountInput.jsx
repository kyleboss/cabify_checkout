import React from "react";

export default class DiscountInput extends React.Component {

    firstInput = function() {
        return(
            <div className='discounts__input-container'>
                <div className='discounts__input-label'>
                    { this.props.product.type === 'BuyXGetXProduct' && `Buy` }
                    { this.props.product.type === 'BulkProduct' && `Threshold` }
                </div>
                {this.props.product.type === 'BuyXGetXProduct' &&
                <input
                    type='number'
                    onChange={(e) => this.props.updateProductProperty(e, 'numToBuy')}
                    className='discounts__input discounts__input-text'
                    value={this.props.product.numToBuy}
                />
                }
                {this.props.product.type === 'BulkProduct' &&
                    <input
                        type='number'
                        onChange={(e) => this.props.updateProductProperty(e, 'bulkThreshold')}
                        className='discounts__input discounts__input-text'
                        value={this.props.product.bulkThreshold}
                    />
                }
            </div>
        );
    };

    secondInput = function() {
        return(
            <div className='discounts__input-container'>
                <div className='discounts__input-label'>
                    { this.props.product.type === 'BuyXGetXProduct' && `Get` }
                    { this.props.product.type === 'BulkProduct' && `Bulk price` }
                </div>
                {this.props.product.type === 'BuyXGetXProduct' &&
                    <input
                        type='number'
                        onChange={(e) => this.props.updateProductProperty(e, 'numWillGet')}
                        className='discounts__input discounts__input-text'
                        value={this.props.product.numWillGet}
                    />
                }
                {this.props.product.type === 'BulkProduct' &&
                    <input
                        onChange={(e) => this.props.updateProductProperty(e, 'bulkPrice')}
                        className='discounts__input discounts__input-text'
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