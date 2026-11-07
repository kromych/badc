
string_literal_address_constant.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	stur	wzr, [x29, #-0x8]
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrb	w1, [x1]
               	cmp	w1, #0x65
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrb	w1, [x1]
               	cmp	w1, #0x6c
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	ldrb	w1, [x1]
               	cmp	w1, #0x6c
               	b.eq	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x68
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x6f
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x65
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	ldrb	w0, [x0]
               	cmp	w0, #0x6c
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	cmp	w1, #0x62
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	ldrb	w1, [x1, #0x1]
               	cmp	w1, #0x64
               	b.ne	<addr>
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0]
               	cmp	w0, #0x66
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	w0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	w0, [x0]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrh	w0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	w0, [x0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x81
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xa0]
               	cmp	w0, #0xff
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xa8]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xb0]
               	cmp	w0, #0x61
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xb8]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xc8]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xd0]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xd8]
               	mov	x17, #0x8000            // =32768
               	cmp	w0, w17
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xe0]
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	ldr	x0, [x1, #0xe8]
               	ldrb	w0, [x0]
               	cmp	w0, #0x79
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrb	w0, [x0]
               	cmp	w0, #0x7a
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldr	w0, [x0]
               	cmp	w0, #0x79
               	b.eq	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x1, [x1, #0xe8]
               	ldrb	w1, [x1]
               	cmp	w1, #0x79
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldr	x2, [x1, #0xf0]
               	ldrb	w2, [x2]
               	cmp	w2, #0x7a
               	b.ne	<addr>
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	ldr	w2, [x2]
               	cmp	w2, #0x79
               	b.eq	<addr>
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	ldrb	w0, [x0]
               	cmp	w0, #0x79
               	b.ne	<addr>
               	ldrb	w0, [x1]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x10]
               	ldr	w0, [x0, x1, lsl #2]
               	cmp	w0, #0x62
               	b.ne	<addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x10]
               	lsl	x1, x1, #1
               	ldr	w0, [x0, w1, sxtw #2]
               	cmp	w0, #0x7a
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x8]
               	ldrh	w0, [x0, x1, lsl #1]
               	eor	x0, x0, #0x8000
               	cbnz	w0, <addr>
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	ldursw	x1, [x29, #-0x8]
               	ldrb	w0, [x0, x1]
               	cmp	w0, #0xff
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x1, #0xf0]
               	b	<addr>
               	ldr	x0, [x1, #0xe8]
               	b	<addr>
