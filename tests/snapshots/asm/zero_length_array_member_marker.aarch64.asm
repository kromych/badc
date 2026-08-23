
zero_length_array_member_marker.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	sub	x1, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldrb	w10, [x0, #0x8]
               	strb	w10, [x1, #0x8]
               	ldrb	w10, [x0, #0x9]
               	strb	w10, [x1, #0x9]
               	ldrb	w10, [x0, #0xa]
               	strb	w10, [x1, #0xa]
               	ldrb	w10, [x0, #0xb]
               	strb	w10, [x1, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldrsw	x0, [x3]
               	cmp	w0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x2, [x3, #0x4]
               	cmp	w2, #0x2
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x2, [x3, #0x8]
               	cmp	w2, #0x3
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	w2, #0x4
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x4]
               	cmp	w2, #0x5
               	cset	x2, ne
               	cbnz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2, #0x8]
               	cmp	w2, #0x6
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	mov	x17, #0x5a5a            // =23130
               	movk	x17, #0x5a, lsl #16
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x2, [x1]
               	cmp	w2, #0x8
               	b.ne	<addr>
               	ldrsw	x2, [x1, #0x4]
               	cmp	w2, #0x9
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldrsw	x1, [x1, #0x8]
               	cmp	w1, #0xa
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x28
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x29
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
