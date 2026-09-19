
paren_string_char_array_init.aarch64:	file format elf64-littleaarch64

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
               	ldrb	w0, [x2, #0x8]
               	mov	x17, #0x6e              // =110
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x2, #0x9]
               	mov	x17, #0x5f              // =95
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldrb	w0, [x2, #0xf]
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrb	w0, [x2, #0x10]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldrsb	x5, [x3, w0, sxtw]
               	cbz	x5, <addr>
               	add	x5, x2, #0x8
               	ldrb	w5, [x5, w0, sxtw]
               	ldrsb	x1, [x4, w0, sxtw]
               	and	x1, x1, #0xff
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	ldrsb	x5, [x3, w0, sxtw]
               	cbnz	x5, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x5]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	mov	x17, #0x77              // =119
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	eor	x1, x1, #0x70
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x4]
               	mov	x17, #0x6e              // =110
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	ret
