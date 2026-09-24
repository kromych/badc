
inline_asm_a64_lane_transfer.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x7               // =7
               	mov	x17, #0x2a              // =42
               	mov	v0.s[0], w16
               	mov	v0.s[2], w17
               	mov	w0, v0.s[2]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0xee              // =238
               	dup	v0.16b, w16
               	smov	w0, v0.b[0]
               	mov	x17, #-0x12             // =-18
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x2a               // =42
               	ret
