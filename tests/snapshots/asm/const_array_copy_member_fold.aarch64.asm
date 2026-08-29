
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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x1                // =1
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x0, #0x1                // =1
               	mov	x2, x0
               	mov	x2, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x8                // =8
               	strb	w2, [x0, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x4
               	ldrb	w2, [x0]
               	ldrb	w3, [x0, #0x1]
               	ldrb	w4, [x0, #0x2]
               	ldrb	w5, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x4               // =4
               	eor	x0, x0, x17
               	mov	w2, w0
               	mov	x0, #0x0                // =0
               	cbnz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x2, x4, x17
               	mov	x17, #0x1               // =1
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x2, x5, x17
               	mov	x17, #0x8               // =8
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	add	x3, x3, #0x1
               	str	w3, [x2]
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	stur	w2, [x29, #-0x8]
               	ldursw	x2, [x29, #-0x8]
               	lsl	x2, x2, #2
               	add	x2, x1, x2
               	ldrb	w3, [x2]
               	ldrb	w4, [x2, #0x2]
               	mov	x17, #0xff              // =255
               	and	x2, x3, x17
               	mov	x17, #0x3c              // =60
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbnz	x2, <addr>
               	mov	x17, #0xff              // =255
               	and	x0, x4, x17
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x2, x17
               	mov	x17, #0x5               // =5
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x3, x17
               	mov	x17, #0x0               // =0
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x17, #0xff              // =255
               	and	x0, x4, x17
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
