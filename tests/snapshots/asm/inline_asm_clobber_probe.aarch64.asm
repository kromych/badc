
inline_asm_clobber_probe.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x16, [sp]
               	mov	w4, #0x1234             // =4660
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	ldr	x16, [sp]
               	str	w4, [x16]
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x1234            // =4660
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
