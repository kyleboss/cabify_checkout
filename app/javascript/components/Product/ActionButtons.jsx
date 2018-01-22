import React from "react";

export default class ActionButtons extends React.Component {
    render() {
        return(
            <div className='action-buttons'>
                <button
                    className='action-buttons__save'
                    onClick={(e) => this.props.saveProduct(this.props.product)}
                >
                    Save
                </button>
                {this.props.product.id >= 0 &&
                    <button
                        onClick={(e) => this.props.removeProduct(this.props.product.id)}
                        className='action-buttons__remove'
                    >
                        Remove
                    </button>
                }
            </div>
        );
    };
};