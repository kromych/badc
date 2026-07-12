
scalar_brace_initializer.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w0, [x1]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w0, [x1, #0x1]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x2]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
