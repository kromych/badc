
inline_asm_a64_hvc_inout.aarch64:	file format elf64-littleaarch64

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
               	cmp	w0, #0x0
               	b.ge	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x16, #0x84000000        // =2214592512
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	mov	x16, #0x2               // =2
               	str	x16, [sp, #0x10]
               	mov	x16, #0x3               // =3
               	str	x16, [sp, #0x18]
               	mov	x16, #0x4               // =4
               	str	x16, [sp, #0x20]
               	mov	x16, #0x5               // =5
               	str	x16, [sp, #0x28]
               	mov	x16, #0x6               // =6
               	str	x16, [sp, #0x30]
               	mov	x16, #0x7               // =7
               	str	x16, [sp, #0x38]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	ldr	x2, [sp, #0x10]
               	ldr	x3, [sp, #0x18]
               	ldr	x4, [sp, #0x20]
               	ldr	x5, [sp, #0x28]
               	ldr	x6, [sp, #0x30]
               	ldr	x7, [sp, #0x38]
               	hvc	#0
               	mov	x16, #0x84000000        // =2214592512
               	str	x16, [sp]
               	mov	x16, #0x1               // =1
               	str	x16, [sp, #0x8]
               	ldr	x0, [sp]
               	ldr	x1, [sp, #0x8]
               	smc	#0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ret
