
sys_addr_zero_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4002b8 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	adrp	x19, 0x410000
               	add	x19, x19, #0xe8
               	mov	x15, x19
               	ldr	x20, [x15]
               	mov	x9, x20
               	blr	x9
               	mov	x15, x0
               	sxtw	x20, w15
               	cmp	x20, #0x0
               	b.gt	0x400318 <.text+0x78>
               	mov	x20, #0x1               // =1
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf0
               	mov	x15, x19
               	ldr	x21, [x15]
               	mov	x9, x21
               	blr	x9
               	mov	x15, x0
               	mov	x15, #0x2a              // =42
               	mov	x0, x15
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	bl	0x4004f8 <geteuid>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	bl	0x400504 <getpid>
               	sxtw	x0, w0
               	mov	x15, x0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
