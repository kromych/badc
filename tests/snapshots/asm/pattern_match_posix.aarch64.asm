
pattern_match_posix.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	sxtw	x23, w20
               	mov	x17, #0x18              // =24
               	mul	x24, x23, x17
               	add	x21, x22, x24
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	ldrsw	x2, [x21, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldrsw	x1, [x21, #0x14]
               	cmp	w0, w1
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	cmp	w20, #0x37
               	b.lt	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x24, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x22, w21
               	mov	x17, #0x30              // =48
               	mul	x23, x22, x17
               	add	x0, x0, x23
               	ldr	x1, [x0]
               	ldrsw	x2, [x0, #0x8]
               	mov	x0, x24
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x20, x29, #0x10
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	w0, [x20]
               	str	w0, [x20, #0x4]
               	str	w0, [x20, #0x8]
               	str	w0, [x20, #0xc]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x0, x1, x23
               	ldr	x2, [x0, #0x10]
               	mov	x3, #0x2                // =2
               	ldrsw	x4, [x0, #0x18]
               	mov	x0, x24
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w21
               	mov	x17, #0x30              // =48
               	mul	x3, x2, x17
               	add	x0, x0, x3
               	ldrsw	x0, [x0, #0x1c]
               	cmp	w1, w0
               	b.ne	<addr>
               	cmp	w1, #0x0
               	cset	x0, eq
               	cbnz	x1, <addr>
               	ldrsw	x1, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x3
               	ldrsw	x0, [x0, #0x20]
               	cmp	w1, w0
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x4, [x20, #0x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldrsw	x1, [x1, #0x24]
               	cmp	w4, w1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x4, [x20, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	add	x1, x1, x3
               	ldrsw	x1, [x1, #0x28]
               	cmp	w4, w1
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x3
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w1, w0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	bl	<addr>
               	uxtb	w0, w0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	cmp	w21, #0x2f
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x50
               	bl	<addr>
               	uxtb	w0, w0
               	add	x0, x21, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x50
               	bl	<addr>
               	uxtb	w0, w0
               	add	x0, x21, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	add	x0, x21, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
               	add	x0, x20, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
