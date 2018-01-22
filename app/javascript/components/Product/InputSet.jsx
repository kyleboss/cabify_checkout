import React from "react";

export default class InputSet extends React.Component {

    render() {
        return(
            <div className={this.props.containerClass}>
                <div className={this.props.labelClass}>{this.props.label}</div>
                <input
                    className={this.props.inputClass}
                    placeholder={this.props.placeholder}
                    onChange={(e) => this.props.updateProductProperty(e, this.props.propertyName)}
                    value={this.props.value}
                    type={this.props.type || 'text'}
                />
                <div className={`${this.props.errorClass} ${this.props.errorValue ? 'active-error' : ''}`}>
                    {this.props.errorValue}
                </div>
            </div>
        );
    };
};