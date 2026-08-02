
aggregate_init_statement_expression_element.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_nested_aggregate>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	sxtw	x20, w20
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	w20, [x0]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x4]
               	add	x0, x20, #0x1
               	add	x1, x20, #0x2
               	add	x2, x20, #0x3
               	mov	w0, w0
               	mov	w1, w1
               	add	x0, x0, x1
               	mov	w0, w0
               	mov	w1, w2
               	add	x0, x0, x1
               	mov	w1, w0
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	ldr	w1, [x0]
               	mov	w2, w20
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x3               // =3
               	mul	x0, x20, x17
               	add	x0, x0, #0x6
               	sxtw	x0, w0
               	mov	w0, w0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x1000             // =4096
               	stur	w0, [x29, #-0x28]
               	ldursw	x20, [x29, #-0x28]
               	sxtw	x1, w20
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldrb	w10, [x2, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x2, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x2, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x2, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0xc3d4             // =50132
               	movk	x0, #0xa1b2, lsl #16
               	sub	x2, x29, #0x20
               	str	w0, [x2]
               	mov	x2, #0x2                // =2
               	sub	x0, x29, #0x20
               	str	w2, [x0, #0x4]
               	mov	x2, #0x100              // =256
               	sxtw	x0, w1
               	cmp	x0, #0x100
               	b.le	<addr>
               	add	x0, x0, #0x30
               	sub	x1, x29, #0x20
               	str	w0, [x1, #0x8]
               	sub	x0, x29, #0x20
               	bl	<addr>
               	ldr	w1, [x0]
               	mov	x17, #0xc3d4            // =50132
               	movk	x17, #0xa1b2, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x28]
               	ldursw	x20, [x29, #-0x28]
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldrb	w10, [x1, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x1, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x1, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x1, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	w20, [x0]
               	mov	x1, #0x15               // =21
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x4]
               	mov	x1, #0x1e               // =30
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	x1, x20
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x28]
               	ldursw	x0, [x29, #-0x28]
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x15
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldr	w1, [x0, #0x4]
               	mov	x17, #0x2               // =2
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldr	w0, [x0, #0x8]
               	cmp	x20, #0x100
               	b.le	<addr>
               	mov	w1, w20
               	add	x1, x1, #0x30
               	mov	w1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x20, #0x100             // =256
               	b	<addr>
               	mov	x0, x2
               	b	<addr>
