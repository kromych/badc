
speculative_init_parse_data_rewind.aarch64:	file format elf64-littleaarch64

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
               	cmp	w1, #0x1
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x2, [x1]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x2, [x0, #0x8]
               	ldr	w2, [x2]
               	mov	x17, #0xa               // =10
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldr	x2, [x0, #0x8]
               	ldr	w2, [x2, #0x4]
               	mov	x17, #0x14              // =20
               	eor	x2, x2, x17
               	cbnz	w2, <addr>
               	ldr	x0, [x0, #0x8]
               	ldr	w0, [x0, #0x8]
               	cbz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x1, #0x8]
               	ldr	w0, [x0]
               	eor	x0, x0, #0x1e
               	cbnz	w0, <addr>
               	ldr	x0, [x1, #0x8]
               	ldr	w0, [x0, #0x4]
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
