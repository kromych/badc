
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
               	ldrsw	x0, [x1, #0x18]
               	cmp	w0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldrsw	x2, [x0, #0x20]
               	add	x3, x2, #0x1
               	str	w3, [x0, #0x20]
               	mov	x17, #0x11d7            // =4567
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x2, x3
               	add	x3, x2, #0x1
               	str	w3, [x0, #0x20]
               	mov	x17, #0x11d8            // =4568
               	cmp	w2, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x1, #0x18]
               	cmp	w0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
