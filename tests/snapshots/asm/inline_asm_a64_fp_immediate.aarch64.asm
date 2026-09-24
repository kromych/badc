
inline_asm_a64_fp_immediate.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #2.00000000
               	fmov	x0, d0
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	v0.4s, #1.00000000
               	mov	w0, v0.s[2]
               	mov	x17, #0x3f800000        // =1065353216
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x2a               // =42
               	ret
