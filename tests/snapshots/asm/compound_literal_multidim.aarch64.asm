
compound_literal_multidim.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	ldrsb	x1, [x1]
               	ldr	x2, [x0, #0x10]
               	ldrsb	x2, [x2, #0x1]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	ldrsb	x2, [x2, #0x2]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2, #0x1]
               	add	x1, x1, x2
               	ldr	x2, [x0, #0x10]
               	add	x2, x2, #0x3
               	ldrsb	x2, [x2, #0x2]
               	add	x1, x1, x2
               	cmp	w1, #0x15
               	b.ne	<addr>
               	ldr	x0, [x0, #0x10]
               	ldrsb	x0, [x0, #0x5]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x20]
               	ldrsw	x2, [x1]
               	cmp	w2, #0xa
               	b.ne	<addr>
               	ldrsw	x1, [x1, #0xc]
               	cmp	w1, #0xd
               	b.ne	<addr>
               	ldr	x0, [x0, #0x20]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x15
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x58]
               	cmp	w0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0xd8]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x6
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x0, #0x0                // =0
               	ret
