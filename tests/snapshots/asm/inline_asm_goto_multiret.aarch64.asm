
inline_asm_goto_multiret.aarch64:	file format elf64-littleaarch64

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
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	nop
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	b	<addr>
               	add	x1, x1, #0x1
               	cmp	x1, #0xa
               	b.ne	<addr>
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	cmp	x1, #0xa
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x2a               // =42
               	ret
               	add	x0, x0, #0x2
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ret
