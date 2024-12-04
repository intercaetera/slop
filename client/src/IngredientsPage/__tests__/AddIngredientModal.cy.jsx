import { AddIngredientModal } from '../AddIngredientModal'
import { Providers } from '../../Providers';

const mountComponent = props => cy.mount(
  <Providers>
    <AddIngredientModal {...props} />
  </Providers>
);

describe('<AddIngredientModal />', () => {
  it('renders', () => {
    mountComponent({})

    cy.contains('+ Add Ingredient')
      .should('exist')
  })

  it('opens the modal when the button is clicked', () => {
    mountComponent({})

    cy.contains('+ Add Ingredient')
      .click()

    cy.contains('h2', 'Add Ingredient')
      .should('be.visible')
  })

  it('calls the mutation when submitting the form', () => {
    const createIngredient = cy.stub()

    mountComponent({ createIngredient })

    cy.contains('+ Add Ingredient')
      .click()

    cy.get('[name="name"]')
      .type('gouda cheese')

    cy.contains('Select unit')
      .click()

    cy.contains(/^g$/)
      .click()

    cy.contains('button', /^Add$/)
      .click()
      .then(() => {
        expect(createIngredient).to.be.calledOnce
      })
  })
})
