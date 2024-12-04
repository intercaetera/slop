import { Button, Input, VStack, createListCollection } from '@chakra-ui/react'
import {
  DialogBody,
  DialogBackdrop,
  DialogCloseTrigger,
  DialogContent,
  DialogFooter,
  DialogHeader,
  DialogRoot,
  DialogTitle,
  DialogTrigger,
} from '../components/ui/dialog'
import { Field } from '../components/ui/field'
import { 
  SelectContent,
  SelectItem,
  SelectRoot,
  SelectTrigger,
  SelectValueText,
} from '../components/ui/select'
import { toaster } from '../components/ui/toaster'
import { useRef, useState } from 'react'
import { useQueryClient, useMutation } from '@tanstack/react-query'
import { createIngredient as createIngredientEffect } from '../api/inventory'
import { useFormik } from 'formik'
import * as yup from 'yup'

export const AddIngredientModal = ({
  createIngredient = createIngredientEffect
}) => {
  const [open, setOpen] = useState(false)
  const contentRef = useRef(null)

  const qc = useQueryClient()

  const formik = useFormik({
    initialValues: {
      name: '',
      unit: '',
    },
    onSubmit: ingredient => {
      submitMutation.mutate({ ingredient })
    },
    validationSchema: yup.object({
      name: yup.string().required('Required'),
      unit: yup.string().required('Required'),
    })
  })

  const submitMutation = useMutation({
    mutationFn: createIngredient,
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ['ingredients'] })
      toaster.create({ type: 'success', title: "Ingredient added successfully" })
    },
    onError: error => {
      console.error(error)
      toaster.create({ type: 'error', title: 'Something went wrong', description: error.message })
    }
  })

  return (
    <DialogRoot open={open} onOpenChange={e => setOpen(e.open)}>
      <DialogBackdrop />
      <DialogTrigger asChild>
        <Button variant="outline" size="xs" onClick={() => setOpen(true)}>
          + Add Ingredient
        </Button>
      </DialogTrigger>
      <DialogContent ref={contentRef} as="form" onSubmit={formik.handleSubmit}>
        <DialogCloseTrigger />
        <DialogHeader>
          <DialogTitle>Add Ingredient</DialogTitle>
        </DialogHeader>
        <DialogBody>
          <VStack gap={4}>
            <Field
              label="Name"
              orientation="horizontal"
              invalid={formik.touched.name && formik.errors.name}
              errorText={formik.errors.name}
            >
              <Input
                name="name"
                onChange={formik.handleChange}
                value={formik.values.name}
                onBlur={formik.handleBlur}
              />
            </Field>

            <Field 
              label="Unit"
              orientation="horizontal"
              invalid={formik.touched.unit && formik.errors.unit}
              errorText={formik.errors.unit}
            >
              <SelectRoot
                name="unit"
                collection={units}
                value={[formik.values.unit]}
                onValueChange={e => formik.setFieldValue('unit', e.value[0])}
              >
                <SelectTrigger>
                  <SelectValueText placeholder="Select unit" />
                </SelectTrigger>
                <SelectContent portalRef={contentRef}>
                  {units.items.map(unit => (
                    <SelectItem item={unit} key={unit.value}>{unit.label}</SelectItem>
                  ))}
                </SelectContent>
              </SelectRoot>
            </Field>
          </VStack>
        </DialogBody>
        <DialogFooter>
          <Button colorPalette="green" type="submit">Add</Button>
        </DialogFooter>
      </DialogContent>
    </DialogRoot>
  )
}

const units = createListCollection({
  items: [
    { label: 'g', value: 'g' },
    { label: 'ml', value: 'ml' },
    { label: 'pieces', value: 'pieces' },
  ]
})
