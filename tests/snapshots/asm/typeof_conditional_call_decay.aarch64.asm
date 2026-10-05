
typeof_conditional_call_decay.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	ldrb	w2, [x1, x0]
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	ldrb	w2, [x1, x0]
               	cbnz	x2, <addr>
               	cmp	x0, #0x3
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x9
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
