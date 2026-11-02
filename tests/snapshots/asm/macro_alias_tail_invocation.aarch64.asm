
macro_alias_tail_invocation.aarch64:	file format elf64-littleaarch64

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
               	adrp	x3, <page>
               	ldrsw	x0, [x3, #0x18]
               	cbz	x0, <addr>
               	mov	x1, #0xb                // =11
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x30]
               	add	x2, x2, #0x1
               	str	w2, [x0, #0x30]
               	adrp	x0, <page>
               	str	w1, [x0, #0x38]
               	adrp	x1, <page>
               	ldrsw	x0, [x1, #0x30]
               	cmp	w0, #0x1
               	b.ne	<addr>
               	adrp	x2, <page>
               	ldrsw	x0, [x2, #0x38]
               	cmp	w0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x3, #0x18]
               	cbz	x0, <addr>
               	mov	x0, #0x16               // =22
               	ldrsw	x4, [x1, #0x30]
               	add	x4, x4, #0x1
               	str	w4, [x1, #0x30]
               	str	w0, [x2, #0x38]
               	ldrsw	x0, [x1, #0x30]
               	cmp	w0, #0x2
               	b.ne	<addr>
               	ldrsw	x0, [x2, #0x38]
               	cmp	w0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x0, [x3, #0x18]
               	cbz	x0, <addr>
               	mov	x0, #0x21               // =33
               	ldrsw	x4, [x1, #0x30]
               	add	x4, x4, #0x1
               	str	w4, [x1, #0x30]
               	str	w0, [x2, #0x38]
               	ldrsw	x0, [x1, #0x30]
               	cmp	w0, #0x3
               	b.ne	<addr>
               	ldrsw	x0, [x2, #0x38]
               	cmp	w0, #0x21
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	str	w0, [x3, #0x18]
               	ldrsw	x1, [x1, #0x30]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x2, #0x38]
               	cmp	w1, #0x21
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ret
