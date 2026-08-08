
inline_asm_goto_multiret.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x3                // =3
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x16               // =22
               	nop
               	mov	x0, #0x5                // =5
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x21               // =33
               	b	<addr>
               	mov	x0, #0x8                // =8
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x7                // =7
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x4                // =4
               	b	<addr>
