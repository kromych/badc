
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
               	mov	x21, #0x0               // =0
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x24, x22, x17
               	add	x20, x23, x24
               	ldr	x0, [x20]
               	ldr	x1, [x20, #0x8]
               	ldrsw	x2, [x20, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x0, w0
               	ldrsw	x1, [x20, #0x14]
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x21, x22, #0x1
               	sxtw	x22, w21
               	cmp	x22, #0x37
               	b.lt	<addr>
               	mov	x21, #0x0               // =0
               	b	<addr>
               	sub	x24, x29, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
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
               	mov	x0, #0x0                // =0
               	sxtw	x3, w0
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	sxtw	x1, w21
               	mov	x17, #0x30              // =48
               	mul	x2, x1, x17
               	add	x4, x4, x2
               	ldrsw	x4, [x4, #0x1c]
               	cmp	x3, x4
               	b.ne	<addr>
               	cmp	x3, #0x0
               	cset	x0, eq
               	cbnz	x3, <addr>
               	ldrsw	x3, [x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x20]
               	cmp	x3, x0
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x4, [x20, #0x4]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, x2
               	ldrsw	x3, [x3, #0x24]
               	cmp	x4, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrsw	x4, [x20, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	add	x3, x3, x2
               	ldrsw	x3, [x3, #0x28]
               	cmp	x4, x3
               	cset	x3, ne
               	cbnz	x3, <addr>
               	sub	x0, x29, #0x10
               	ldrsw	x3, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x2c]
               	cmp	x3, x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	bl	<addr>
               	uxtb	w0, w0
               	b	<addr>
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	sxtw	x22, w21
               	cmp	x22, #0x2f
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
               	add	x0, x21, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret
