
static_local_shadows_global.aarch64:	file format elf64-littleaarch64

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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	w0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x17, #0x11d7            // =4567
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x2, [x0]
               	add	x3, x2, #0x1
               	str	w3, [x0]
               	mov	x17, #0x11d8            // =4568
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x1]
               	cmp	w0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
