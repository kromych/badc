
one_word_aggregate_argument_takes_its_value.aarch64:	file format elf64-littleaarch64

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

<regs>:
               	add	x0, x0, x0, lsl #1
               	fcvtzu	x2, d0
               	add	x0, x0, x2
               	add	x0, x0, x1
               	ret

<stacked>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	sub	x16, x29, #0x8
               	ldr	x17, [x29, #0x20]
               	str	x17, [x16]
               	ldrsw	x0, [x29, #0x18]
               	add	x0, x0, #0x24
               	ldur	x1, [x29, #-0x10]
               	add	x1, x1, x1, lsl #2
               	add	x0, x0, x1
               	fcvtzu	x1, d0
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	mov	x17, #0x7               // =7
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<reals>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x10
               	ldr	x17, [x29, #0x10]
               	str	x17, [x16]
               	sub	x16, x29, #0x8
               	ldr	x17, [x29, #0x18]
               	str	x17, [x16]
               	fadd	d0, d0, d1
               	fadd	d0, d0, d2
               	fadd	d0, d0, d3
               	fadd	d0, d0, d4
               	fadd	d0, d0, d5
               	fadd	d0, d0, d6
               	fadd	d0, d0, d7
               	ldur	d1, [x29, #-0x10]
               	fmov	d2, #10.00000000
               	fmadd	d0, d1, d2, d0
               	ldur	d1, [x29, #-0x8]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d2, x16
               	fmadd	d0, d1, d2, d0
               	ucvtf	d1, x0
               	fadd	d0, d0, d1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<run>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	d8, [sp, #0x20]
               	stp	x20, x21, [sp, #0x30]
               	str	x22, [sp, #0x40]
               	ldr	x21, [x0]
               	ldr	x20, [x0, #0x8]
               	ldr	d8, [x1]
               	fmov	d0, d8
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	str	x21, [sp]
               	mov	x16, #0x9               // =9
               	str	x16, [sp, #0x8]
               	str	x20, [sp, #0x10]
               	fmov	d0, d8
               	bl	<addr>
               	add	x22, x22, x0
               	fmov	d0, #1.00000000
               	fmov	d1, #2.00000000
               	fmov	d2, #3.00000000
               	fmov	d3, #4.00000000
               	fmov	d4, #5.00000000
               	fmov	d5, #6.00000000
               	fmov	d6, #7.00000000
               	fmov	d7, #8.00000000
               	str	d8, [sp]
               	str	d8, [sp, #0x8]
               	mov	x0, x20
               	bl	<addr>
               	fcvtzu	x0, d0
               	add	x22, x22, x0
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	fmov	d0, d8
               	mov	x0, x20
               	mov	x1, x21
               	blr	x2
               	add	x0, x22, x0
               	ldr	x22, [sp, #0x40]
               	ldp	x20, x21, [sp, #0x30]
               	ldr	d8, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x1                // =1
               	cmp	x0, #0x314
               	csel	x0, x1, x2, eq
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
