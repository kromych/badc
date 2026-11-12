
int128_return_scalar.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x1, #0x10]
               	asr	x2, x0, #63
               	eor	x3, x0, #0xfffffffffffffffd
               	mvn	x2, x2
               	orr	x2, x3, x2
               	cbz	x2, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	asr	x0, x0, #63
               	asr	x2, x0, #63
               	mvn	x0, x0
               	mvn	x2, x2
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mvn	x0, x0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldr	x0, [x1, #0x10]
               	asr	x1, x0, #63
               	eor	x2, x0, #0xfffffffffffffffd
               	mvn	x1, x1
               	orr	x1, x2, x1
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	add	x0, x0, #0x4
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
