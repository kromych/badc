
static_init_paren_cast_string.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	mov	x17, #0x5               // =5
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0]
               	ldrb	w1, [x1, #0x5]
               	mov	x17, #0x1a              // =26
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrb	w1, [x1]
               	mov	x17, #0x9               // =9
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0, #0x8]
               	ldrb	w1, [x1, #0x9]
               	mov	x17, #0x4               // =4
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x0, #0x10]
               	ldrb	w0, [x0, #0x9]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
