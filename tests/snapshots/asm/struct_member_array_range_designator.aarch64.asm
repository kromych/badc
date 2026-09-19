
struct_member_array_range_designator.aarch64:	file format elf64-littleaarch64

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
               	ldrsw	x1, [x0]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x10]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x14]
               	cmp	w0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0xc]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
