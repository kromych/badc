
empty_array_init.aarch64:	file format elf64-littleaarch64

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
               	ldr	x1, [x0]
               	cmp	x1, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x0
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
