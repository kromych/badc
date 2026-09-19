
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	strb	w1, [x0, #0x7]
               	add	x0, x0, #0x4
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w0, [x0, #0x3]
               	eor	x1, x1, #0x4
               	cbnz	w1, <addr>
               	cbnz	w2, <addr>
               	eor	x1, x3, #0x1
               	cbnz	w1, <addr>
               	eor	x0, x0, #0x8
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldursw	x2, [x29, #-0x8]
               	lsl	x2, x2, #2
               	add	x2, x1, x2
               	ldrb	w3, [x2]
               	ldrb	w2, [x2, #0x2]
               	eor	x3, x3, #0x3c
               	cbnz	w3, <addr>
               	eor	x2, x2, #0x1
               	cbz	w2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x2, #0x3c               // =60
               	mov	x3, #0x34               // =52
               	mov	x5, #0x2                // =2
               	mov	x4, x0
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	mov	x2, #0x7                // =7
               	mov	x3, #0x5                // =5
               	mov	x5, #0x1                // =1
               	mov	x4, x1
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
