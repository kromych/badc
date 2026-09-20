
computed_goto_const_static_table.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<interp_ptr_const>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1                // =1
               	ldrb	w5, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x3, [x3, x5, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	add	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	sub	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	add	x0, x0, x0
               	sxtw	x3, w1
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	ret

<interp_decl_const>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1                // =1
               	ldrb	w5, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x3, [x3, x5, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	add	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	sub	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	add	x0, x0, x0
               	sxtw	x3, w1
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	ret

<interp_long>:
               	mov	x2, x0
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0x1                // =1
               	ldrb	w5, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	x3, [x3, x5, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	add	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	ldrb	w1, [x2, x1]
               	sub	x0, x0, x1
               	sxtw	x3, w3
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	add	x0, x0, x0
               	sxtw	x3, w1
               	add	x1, x3, #0x1
               	ldrb	w3, [x2, x3]
               	ldr	x3, [x4, x3, lsl #3]
               	br	x3
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x1, [x1]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x1, [x0]
               	ldr	x0, [x1]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
