
two_d_array_param_indexing.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xe8
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x100
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x106
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x10d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrh	w1, [x0]
               	ldrh	w0, [x0, #0x2]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	sxtw	x1, w1
               	mov	x17, #0xc               // =12
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret
               	sxtw	x1, w1
               	lsl	x1, x1, #2
               	add	x0, x0, x1
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrb	w2, [x0, #0x2]
               	add	x1, x1, x2
               	sxtw	x1, w1
               	ldrb	w0, [x0, #0x3]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x4d0
               	str	x20, [sp]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x100
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x400
               	sxtw	x2, w1
               	lsl	x2, x2, #2
               	add	x0, x0, x2
               	mov	x2, #0x0                // =0
               	strh	w2, [x0]
               	sub	x0, x29, #0x400
               	sxtw	x3, w1
               	lsl	x3, x3, #2
               	add	x0, x0, x3
               	strh	w2, [x0, #0x2]
               	b	<addr>
               	sub	x0, x29, #0x400
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0x14]
               	sub	x0, x29, #0x400
               	mov	x1, #0x10               // =16
               	strh	w1, [x0, #0x16]
               	sub	x0, x29, #0x400
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	mov	x17, #0x1244            // =4676
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0xa
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x480
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x837
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x480
               	sxtw	x2, w20
               	mov	x17, #0xc               // =12
               	mul	x3, x2, x17
               	add	x0, x0, x3
               	sxtw	x3, w1
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	sxtw	x2, w2
               	add	x2, x2, x3
               	sxtw	x2, w2
               	str	w2, [x0, x3, lsl #2]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x4a8
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x116
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x4a8
               	sxtw	x2, w20
               	lsl	x3, x2, #2
               	add	x0, x0, x3
               	sxtw	x3, w1
               	add	x0, x0, x3
               	add	x2, x2, #0x41
               	sxtw	x2, w2
               	add	x2, x2, x3
               	sxtw	x2, w2
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	strb	w2, [x0]
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x4d0
               	ldp	x29, x30, [sp], #0x10
               	ret
