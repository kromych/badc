
attribute_cleanup.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x1, <page>
               	mov	x4, #0x0                // =0
               	mov	x0, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x1                // =1
               	str	w3, [x1, #0x120]
               	str	w0, [x2, x4, lsl #2]
               	mov	x3, #0x2                // =2
               	ldrsw	x0, [x1, #0x120]
               	add	x5, x0, #0x1
               	str	w5, [x1, #0x120]
               	str	w3, [x2, x0, lsl #2]
               	mov	x0, #0x1                // =1
               	ldrsw	x3, [x1, #0x120]
               	add	x5, x3, #0x1
               	str	w5, [x1, #0x120]
               	str	w0, [x2, x3, lsl #2]
               	ldrsw	x3, [x1, #0x120]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x2]
               	cmp	w3, #0x3
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x4]
               	cmp	w3, #0x2
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x8]
               	cmp	w3, #0x1
               	b.eq	<addr>
               	ret
               	str	w4, [x1, #0x120]
               	adrp	x0, <page>
               	str	w4, [x0, #0x124]
               	mov	x3, #0x2bc              // =700
               	ldrsw	x0, [x1, #0x120]
               	add	x4, x0, #0x1
               	str	w4, [x1, #0x120]
               	str	w3, [x2, x0, lsl #2]
               	ldrsw	x0, [x1, #0x120]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x0, [x2]
               	cmp	w0, #0x2bc
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x1, #0x120]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	adrp	x1, <page>
               	b	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.ge	<addr>
               	cmp	w0, #0x1
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x120]
               	add	x4, x3, #0x1
               	str	w4, [x1, #0x120]
               	str	w0, [x2, x3, lsl #2]
               	b	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	ldrsw	x3, [x1, #0x120]
               	add	x4, x3, #0x1
               	str	w4, [x1, #0x120]
               	str	w0, [x2, x3, lsl #2]
               	b	<addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x120]
               	add	x4, x2, #0x1
               	str	w4, [x1, #0x120]
               	str	w0, [x3, x2, lsl #2]
               	mov	x2, #0x32               // =50
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x120]
               	add	x4, x1, #0x1
               	str	w4, [x0, #0x120]
               	str	w2, [x3, x1, lsl #2]
               	ldrsw	x0, [x0, #0x120]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x32
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x1, <page>
               	mov	x2, #0x0                // =0
               	mov	x3, #0xc                // =12
               	mov	x4, #0x1                // =1
               	str	w4, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	mov	x4, #0xb                // =11
               	ldrsw	x5, [x1, #0x120]
               	add	x6, x5, #0x1
               	str	w6, [x1, #0x120]
               	str	w4, [x0, x5, lsl #2]
               	mov	x5, #0xa                // =10
               	ldrsw	x6, [x1, #0x120]
               	add	x7, x6, #0x1
               	str	w7, [x1, #0x120]
               	str	w5, [x0, x6, lsl #2]
               	ldrsw	x6, [x1, #0x120]
               	cmp	w6, #0x3
               	b.ne	<addr>
               	ldrsw	x6, [x0]
               	cmp	w6, #0xc
               	b.ne	<addr>
               	ldrsw	x6, [x0, #0x4]
               	cmp	w6, #0xb
               	b.ne	<addr>
               	ldrsw	x6, [x0, #0x8]
               	cmp	w6, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x6, #0x1                // =1
               	str	w6, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x2, [x1, #0x120]
               	add	x3, x2, #0x1
               	str	w3, [x1, #0x120]
               	str	w4, [x0, x2, lsl #2]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x1, #0x120]
               	add	x3, x2, #0x1
               	str	w3, [x1, #0x120]
               	str	w5, [x0, x2, lsl #2]
               	adrp	x1, <page>
               	ldrsw	x2, [x1, #0x120]
               	cmp	w2, #0x3
               	b.ne	<addr>
               	ldrsw	x2, [x0]
               	cmp	w2, #0xc
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x4]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x8]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x2, #0x0                // =0
               	mov	x3, #0x29               // =41
               	mov	x4, #0x1                // =1
               	str	w4, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	mov	x4, #0x28               // =40
               	ldrsw	x5, [x1, #0x120]
               	add	x6, x5, #0x1
               	str	w6, [x1, #0x120]
               	str	w4, [x0, x5, lsl #2]
               	ldrsw	x5, [x1, #0x120]
               	cmp	w5, #0x2
               	b.ne	<addr>
               	ldrsw	x5, [x0]
               	cmp	w5, #0x29
               	b.ne	<addr>
               	ldrsw	x5, [x0, #0x4]
               	cmp	w5, #0x28
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x5, #0x1                // =1
               	str	w5, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x3, [x1, #0x120]
               	add	x5, x3, #0x1
               	str	w5, [x1, #0x120]
               	str	w4, [x0, x3, lsl #2]
               	ldrsw	x1, [x1, #0x120]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x29
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x28
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	adrp	x1, <page>
               	mov	x3, #0x15               // =21
               	mov	x4, #0x1                // =1
               	str	w4, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	mov	x4, #0x14               // =20
               	ldrsw	x5, [x1, #0x120]
               	add	x6, x5, #0x1
               	str	w6, [x1, #0x120]
               	str	w4, [x0, x5, lsl #2]
               	ldrsw	x5, [x1, #0x120]
               	cmp	w5, #0x2
               	b.ne	<addr>
               	ldrsw	x5, [x0]
               	cmp	w5, #0x15
               	b.ne	<addr>
               	ldrsw	x5, [x0, #0x4]
               	cmp	w5, #0x14
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x5, #0x1                // =1
               	str	w5, [x1, #0x120]
               	str	w3, [x0, x2, lsl #2]
               	ldrsw	x2, [x1, #0x120]
               	add	x3, x2, #0x1
               	str	w3, [x1, #0x120]
               	str	w4, [x0, x2, lsl #2]
               	ldrsw	x1, [x1, #0x120]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x15
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x0                // =0
               	ret
