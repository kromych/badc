
packed_bitfield_struct_by_value.aarch64:	file format elf64-littleaarch64

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

<ret_s>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, x0
               	ldr	x0, [x16]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	and	x0, x0, #0xf80000001fffffff
               	mov	x17, #0x40000000        // =1073741824
               	movk	x17, #0x5555, lsl #32
               	movk	x17, #0x555, lsl #48
               	orr	x0, x0, x17
               	str	x0, [x1]
               	sub	x0, x29, #0x8
               	ldrb	w2, [x1, #0x3]
               	ldr	w1, [x1, #0x4]
               	strb	w2, [x0, #0x3]
               	str	w1, [x0, #0x4]
               	ldrb	w1, [x0]
               	ldrb	w2, [x0, #0x1]
               	ldrb	w3, [x0, #0x2]
               	ldrb	w4, [x0, #0x3]
               	ldrb	w5, [x0, #0x4]
               	ldrb	w6, [x0, #0x5]
               	ldrb	w7, [x0, #0x6]
               	ldrb	w8, [x0, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	strb	w1, [x0]
               	strb	w2, [x0, #0x1]
               	strb	w3, [x0, #0x2]
               	strb	w4, [x0, #0x3]
               	strb	w5, [x0, #0x4]
               	strb	w6, [x0, #0x5]
               	strb	w7, [x0, #0x6]
               	strb	w8, [x0, #0x7]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	asr	x0, x0, #29
               	and	x0, x0, #0x3fffffff
               	mov	x17, #0xaaaa            // =43690
               	movk	x17, #0x2aaa, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0xffffffffe0000000
               	mov	x17, #0xfffb            // =65531
               	movk	x17, #0x1fff, lsl #16
               	orr	x1, x1, x17
               	str	w1, [x0]
               	ldr	x1, [x0]
               	and	x1, x1, #0xf80000001fffffff
               	mov	x17, #0xa0000000        // =2684354560
               	movk	x17, #0x9, lsl #32
               	orr	x1, x1, x17
               	str	x1, [x0]
               	bl	<addr>
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x16, [x0]
               	str	x16, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0x1fffffff
               	lsl	x1, x1, #35
               	asr	x1, x1, #35
               	mov	x17, #-0x5              // =-5
               	cmp	w1, w17
               	b.ne	<addr>
               	ldr	x0, [x0]
               	asr	x0, x0, #29
               	and	x0, x0, #0x3fffffff
               	lsl	x0, x0, #34
               	asr	x0, x0, #34
               	cmp	w0, #0x4d
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w0, [x1]
               	and	x0, x0, #0xfffffffffff00000
               	orr	x0, x0, #0xfffff
               	str	w0, [x1]
               	ldur	x0, [x1, #0x2]
               	and	x0, x0, #0xffff00000000000f
               	orr	x0, x0, #0x7ffffffffff0
               	stur	x0, [x1, #0x2]
               	ldr	w0, [x1, #0x8]
               	and	x0, x0, #0xfffffffffff00000
               	mov	x17, #0xbcde            // =48350
               	movk	x17, #0xa, lsl #16
               	orr	x0, x0, x17
               	str	w0, [x1, #0x8]
               	mov	x0, #0x9                // =9
               	strb	w0, [x1, #0xb]
               	sub	x0, x29, #0x10
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldrb	w1, [x0, #0xb]
               	add	x1, x1, #0x1
               	strb	w1, [x0, #0xb]
               	sub	x1, x29, #0x20
               	ldr	x3, [x0]
               	ldr	w2, [x0, #0x8]
               	str	x3, [x1]
               	str	w2, [x1, #0x8]
               	ldr	x16, [x1]
               	str	x16, [x0]
               	ldr	w16, [x1, #0x8]
               	str	w16, [x0, #0x8]
               	ldr	w1, [x0]
               	and	x1, x1, #0xfffff
               	mov	x17, #0xfffff           // =1048575
               	cmp	w1, w17
               	b.ne	<addr>
               	ldur	x1, [x0, #0x2]
               	asr	x1, x1, #4
               	and	x1, x1, #0xfffffffffff
               	mov	x17, #0x7ffffffffff     // =8796093022207
               	cmp	x1, x17
               	b.ne	<addr>
               	and	x1, x2, #0xfffff
               	mov	x17, #0xbcde            // =48350
               	movk	x17, #0xa, lsl #16
               	cmp	w1, w17
               	b.ne	<addr>
               	ldrb	w0, [x0, #0xb]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
