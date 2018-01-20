import React from "react";
import ProductCard from "./ProductCard";
import Summary from "./Summary";

export default class Cart extends React.Component {
    productCards = function() {
        return(this.props.scannedProducts && this.props.scannedProducts.map((product) =>
            <ProductCard
                key={product.title}
                product={product}
                updateProductQuantity={this.props.updateProductQuantity}
                removeProduct={this.props.removeProduct}
            />
        ));
    };
    render() {
        return(
            <div>
                {this.props.scannedProducts && this.props.scannedProducts.length > 0 &&
                <div className='cart'>
                    <div className='product-cards'>
                        {this.productCards()}
                    </div>
                    <Summary
                        cartSummary={this.props.cartSummary}
                        currencySymbol={this.props.currencySymbol}
                        checkout={this.props.checkout}
                    />
                </div>
                }
                {(!this.props.scannedProducts || this.props.scannedProducts.length === 0) &&
                <div className='empty-cart-message'>
                    Scan an item to add it to the shopper's cart.
                </div>
                }
            </div>

        );
    };
};