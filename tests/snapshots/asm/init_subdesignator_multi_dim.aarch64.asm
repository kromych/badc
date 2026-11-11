
init_subdesignator_multi_dim.aarch64:	file format elf64-littleaarch64

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
               	add	x0, x0, <lo12>
               	ldrh	w1, [x0]
               	ldrh	w2, [x0, #0x2]
               	ldrh	w3, [x0, #0xa]
               	ldr	w4, [x0, #0x24]
               	ldr	w5, [x0, #0x2c]
               	ldr	w6, [x0, #0x98]
               	ldrh	w7, [x0]
               	cmp	w7, #0x1
               	b.ne	<addr>
               	ldrh	w7, [x0, #0x2]
               	cmp	w7, #0x2
               	b.ne	<addr>
               	ldrh	w7, [x0, #0xa]
               	cmp	w7, #0x7
               	b.ne	<addr>
               	ldrsw	x7, [x0, #0x24]
               	cmp	w7, #0x5
               	b.ne	<addr>
               	ldrsw	x7, [x0, #0x2c]
               	cmp	w7, #0x6
               	b.ne	<addr>
               	ldrsw	x7, [x0, #0x98]
               	cmp	w7, #0x9
               	b.ne	<addr>
               	ldrh	w7, [x0, #0x6]
               	cbnz	w7, <addr>
               	ldrsw	x7, [x0, #0x18]
               	cbnz	w7, <addr>
               	ldrsw	x0, [x0, #0x3c]
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w1, #0x1
               	b.ne	<addr>
               	cmp	w2, #0x2
               	b.ne	<addr>
               	cmp	w3, #0x7
               	b.ne	<addr>
               	cmp	w4, #0x5
               	b.ne	<addr>
               	cmp	w5, #0x6
               	b.ne	<addr>
               	cmp	w6, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x54]
               	cmp	w0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x6c]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrh	w1, [x0, #0x8]
               	cmp	w1, #0x8
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x98]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
