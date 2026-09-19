
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
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	ldrb	w6, [x0, #0x1]
               	ldrb	w7, [x0, #0x2]
               	ldrb	w8, [x0, #0x3]
               	eor	x0, x1, x2
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x6, x3
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x7, x4
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	eor	x0, x8, x5
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	add	x0, x0, #0x4
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	eor	x1, x1, #0x4
               	mov	x0, #0x0                // =0
               	cbnz	w1, <addr>
               	cmp	w2, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x3, #0x1
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	eor	x1, x4, #0x8
               	cmp	w1, #0x0
               	cset	x1, eq
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	mov	x20, #0x1               // =1
               	stur	w20, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldursw	x2, [x29, #-0x8]
               	lsl	x2, x2, #2
               	add	x2, x1, x2
               	ldrb	w3, [x2]
               	ldrb	w2, [x2, #0x2]
               	eor	x3, x3, #0x3c
               	cbnz	w3, <addr>
               	eor	x0, x2, #0x1
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	mov	x2, #0x3c               // =60
               	mov	x3, #0x34               // =52
               	mov	x5, #0x2                // =2
               	mov	x0, x1
               	mov	x4, x20
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0x5                // =5
               	mov	x4, x1
               	mov	x5, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
