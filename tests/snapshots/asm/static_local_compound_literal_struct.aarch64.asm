
static_local_compound_literal_struct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x31
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
