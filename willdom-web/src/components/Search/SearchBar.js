import React, { Component } from 'react';
import { Row, Col, Input, FormGroup, Button, Label } from 'reactstrap';

import { connect } from 'react-redux';
import SearchActions from '../../redux/actions/SearchActions';

class SearchBar extends Component {
  constructor(props) {
    super(props);

    this.state = {
      disableSearch: true,
      text: '',
      engine: 'google', // by default
    };
  }

  onChangeText(text) {
    let disableSearch = true;
    if (text && text.length >= 3) {
      disableSearch = false
    }
    this.setState({ text, disableSearch });
  }

  onChangeEngine(engine) {
    this.setState({ engine });
  }

  onSearch = (e) => {
    e.preventDefault();
    if (!this.state.engine) {
      alert('You need to specify the search engine');
      return;
    }

    if (this.state.text.length < 3) {
      alert('Speficy what you are searching for');
      return;
    }

    this.props.search(this.state.engine, this.state.text);
  }

  render() {
    return (
      <Col xl="12">
        <Row>
          <Col xl="7">
            <FormGroup >
              <Label>What you are searching for?</Label>
              <Input type='text' placeholder="Search here..." value={this.state.text} onChange={(e) => this.onChangeText(e.target.value)} ></Input>
            </FormGroup>
          </Col>
          <Col xl="3">
            <FormGroup>
              <Label for="exampleSelect">Search Engine</Label>
              <Input type="select" onChange={(e) => this.onChangeEngine(e.target.value)}>
                <option value='google'>Google</option>
                <option value='bing'>Bing</option>
                <option value='google_bing'>Google and Bing</option>
              </Input>
            </FormGroup>
          </Col>
          <Col xl="2">
            <Button color="success" style={{ marginTop: '31px' }} disabled={this.state.disableSearch} onClick={this.onSearch}>Search..</Button>
          </Col>
        </Row>
      </Col>
    );
  }
};

const mapStateToProps = state => {
  return {
    searchResults: state.searchReducer.results
  }
};

const mapDispatchToProps = dispatch => ({
  search: (engine, text) => {
    dispatch(SearchActions.search(engine, text));
  }
});


export default connect(mapStateToProps, mapDispatchToProps)(SearchBar);