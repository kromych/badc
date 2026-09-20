
tentative_array_use_before_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	sxtw	x3, w0
               	lsl	x3, x3, #4
               	add	x3, x2, x3
               	ldr	x3, [x3]
               	cbz	x3, <addr>
               	add	x1, x1, #0x1
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	lsl	x3, x3, #4
               	add	x3, x2, x3
               	ldr	x3, [x3]
               	cbnz	x3, <addr>
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0xa
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x28]
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	ldrsw	x2, [x0, #0x4]
               	add	x1, x1, x2
               	ldrsw	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldrsw	x0, [x0, #0xc]
               	add	x0, x1, x0
               	cmp	w0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
