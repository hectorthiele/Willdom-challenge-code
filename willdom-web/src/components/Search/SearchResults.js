import React, { Component } from 'react';

import { connect } from 'react-redux';

import SearchResultItem from './SearchResultItem';

class SearchResults extends Component {

  render() {

    let sortedResults = this.props.searchResults.sort((a, b) => a.title > b.title ? 1 : -1);

    return (
      <div>
        {sortedResults.map((result, idx) => (<SearchResultItem key={idx} result={result} />))}
      </div>
    );
  }
};

const mapStateToProps = state => {
  return {
    searchResults: state.searchReducer.results
  }
};

export default connect(mapStateToProps)(SearchResults);