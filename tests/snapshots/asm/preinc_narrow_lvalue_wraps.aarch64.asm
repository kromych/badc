
preinc_narrow_lvalue_wraps.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<preinc_u16_wrap>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<preinc_u32_wrap>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<compound_u8_wrap>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<compound_u16_wrap>:
               	mov	x1, #0x0                // =0
               	mov	x1, #0x1                // =1
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>

<preinc_u8_through_pointer>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0xff               // =255
               	sturb	w0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	mov	x2, #0x0                // =0
               	ldrb	w1, [x0]
               	add	x1, x1, #0x1
               	strb	w1, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0x1                // =1
               	sxtw	x0, w2
               	cmp	x0, #0x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	ldurb	w0, [x29, #-0x8]
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	bl	<addr>
               	mov	x17, #0x0               // =0
               	orr	x20, x0, x17
               	bl	<addr>
               	orr	x20, x20, x0
               	bl	<addr>
               	orr	x20, x20, x0
               	bl	<addr>
               	orr	x20, x20, x0
               	bl	<addr>
               	orr	x20, x20, x0
               	bl	<addr>
               	orr	x20, x20, x0
               	sxtw	x1, w20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
