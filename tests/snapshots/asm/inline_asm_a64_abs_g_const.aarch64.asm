
inline_asm_a64_abs_g_const.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	mov	x0, #0x1234000000000000 // =1311673391471656960
               	movk	x0, #0x5678, lsl #32
               	movk	x0, #0x90ab, lsl #16
               	movk	x0, #0xcdef
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0xcdef            // =52719
               	movk	x17, #0x90ab, lsl #16
               	movk	x17, #0x5678, lsl #32
               	movk	x17, #0x1234, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	movn	x0, #0x0, lsl #32
               	movk	x0, #0xff3f, lsl #16
               	movk	x0, #0x3000
               	ldr	x16, [sp]
               	str	x0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x3000            // =12288
               	movk	x17, #0xff3f, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	str	x0, [sp, #0x8]
               	str	x0, [sp]
               	mov	w0, #0x5a820000         // =1518469120
               	movk	w0, #0x7999
               	ldr	x16, [sp]
               	str	w0, [x16]
               	ldr	x0, [sp, #0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0x7999            // =31129
               	movk	x17, #0x5a82, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
