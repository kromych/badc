
inline_asm_clobber_probe.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	w4, #0x1234             // =4660
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	mov	x17, #0x1234            // =4660
               	cmp	w4, w17
               	mov	x16, #0x2a              // =42
               	mov	x17, #0x1               // =1
               	csel	x0, x16, x17, eq
               	ret
