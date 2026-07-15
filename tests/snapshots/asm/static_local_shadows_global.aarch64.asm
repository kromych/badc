
static_local_shadows_global.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x0, [x2]
               	cmp	x0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	sxtw	x0, w1
               	sxtw	x0, w0
               	mov	x17, #0x11d7            // =4567
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x3, x1, #0x1
               	str	w3, [x0]
               	sxtw	x0, w1
               	sxtw	x0, w0
               	mov	x17, #0x11d8            // =4568
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldrsw	x0, [x2]
               	cmp	x0, #0x4d2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
