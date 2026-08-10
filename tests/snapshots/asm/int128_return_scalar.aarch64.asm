
int128_return_scalar.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	asr	x3, x2, #63
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x1, x2, x17
               	mvn	x2, x3
               	orr	x1, x1, x2
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0]
               	asr	x2, x1, #63
               	asr	x3, x2, #63
               	mvn	x1, x2
               	mvn	x2, x3
               	orr	x1, x1, x2
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	mvn	x1, x2
               	mov	x17, #0x0               // =0
               	orr	x1, x1, x17
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x2, [x0]
               	asr	x3, x2, #63
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x1, x2, x17
               	mvn	x2, x3
               	orr	x1, x1, x2
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	ldr	x0, [x0]
               	add	x1, x0, #0x4
               	sxtw	x0, w1
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
