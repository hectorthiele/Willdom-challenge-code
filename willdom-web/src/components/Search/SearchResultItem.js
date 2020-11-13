import { Row, Col } from 'reactstrap';

import './styles.css';
import google from '../../images/google.png';
import bing from '../../images/bing.png';

export default function SearchResultItem(props) {

  const imageSource = props.result.source === 'google' ? google : bing;
  return (
    <Row className='item-result'>
      <Col xl="10">
        <a href={props.result.link} target='_blank' rel="noreferrer">
          {props.result.title}
        </a>
      </Col>
      <Col xl="2" className='source-container'>
        <img src={imageSource} className="source-result-img" alt="Source Response"></img>
      </Col>
      <Col xl="12">
        {props.result.snippet}
      </Col>
      <Col xl="12">
        <hr />
      </Col>
    </Row>
  );
}