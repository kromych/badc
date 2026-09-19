
const_array_copy_member_fold.aarch64:	file format elf64-littleaarch64

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

<check_field>:
               	sxtw	x1, w1
               	mov	x8, x4
               	mov	x7, x3
               	mov	x6, x2
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	eor	x0, x1, x6
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x2, x7
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x3, x8
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x4, x5
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x8                // =8
               	strb	w0, [x20, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	ldrb	w1, [x0]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	eor	x1, x1, #0x4
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	cmp	w3, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x4, #0x1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x5, #0x8
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x3, [x1]
               	add	x3, x3, #0x1
               	str	w3, [x1]
               	mov	x21, #0x1               // =1
               	stur	w21, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	lsl	x1, x1, #2
               	add	x1, x2, x1
               	ldrb	w3, [x1]
               	ldrb	w4, [x1, #0x2]
               	eor	x1, x3, #0x3c
               	cbnz	w1, <addr>
               	eor	x0, x4, #0x1
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x3c               // =60
               	mov	x3, #0x34               // =52
               	mov	x5, #0x2                // =2
               	mov	x1, x21
               	mov	x4, x21
               	mov	x16, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0x5                // =5
               	mov	x0, x20
               	mov	x5, x21
               	mov	x4, x1
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
