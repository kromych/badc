
inline_asm_clobber_probe.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	sub	sp, sp, #0x30
               	str	x0, [sp, #0x8]
               	str	x1, [sp, #0x10]
               	str	x2, [sp, #0x18]
               	str	x3, [sp, #0x20]
               	str	x4, [sp, #0x28]
               	str	x0, [sp]
               	mov	w4, #0x1234             // =4660
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	mov	x3, #0x0                // =0
               	ldr	x16, [sp]
               	str	w4, [x16]
               	ldr	x0, [sp, #0x8]
               	ldr	x1, [sp, #0x10]
               	ldr	x2, [sp, #0x18]
               	ldr	x3, [sp, #0x20]
               	ldr	x4, [sp, #0x28]
               	add	sp, sp, #0x30
               	ldursw	x0, [x29, #-0x10]
               	mov	x17, #0x1234            // =4660
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
