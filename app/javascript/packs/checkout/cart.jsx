import React from "react";
import ProductCard from "./product_card";
import Summary from "./summary";

export default class Cart extends React.Component {
    constructor(props) {
        super(props);
    }

    productCards = this.props.scannedProducts.map((product) =>
        <ProductCard product={product} />
    );
    render() {
        return(
            <div>
                {this.props.scannedProducts && this.props.scannedProducts.count() > 0 &&
                <div className='cart'>
                    <div className='product-cards'>
                        {this.productCards}
                    </div>
                    <Summary
                        scannedProducts={this.props.scannedProducts}
                        discounts={this.props.discounts}
                        currencySymbol={this.props.currencySymbol}
                        total={this.props.total}
                    />
                </div>
                }
                {(!this.props.scannedProducts || this.props.scannedProducts.count() === 0) &&
                <div className='empty-cart-message'>
                    Scan an item to add it to the shopper's cart.
                </div>
                }
            </div>

        );
    };
};