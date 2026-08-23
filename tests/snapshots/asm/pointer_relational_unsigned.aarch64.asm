
pointer_relational_unsigned.aarch64:	file format elf64-littleaarch64

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
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x2, ls
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	x1, x0
               	b.ls	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, x1
               	cset	x2, lo
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, x1
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	cmp	x0, x1
               	b.hs	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbnz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
