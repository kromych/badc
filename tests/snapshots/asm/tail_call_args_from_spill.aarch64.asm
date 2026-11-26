
tail_call_args_from_spill.aarch64:	file format elf64-littleaarch64

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

<stir>:
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	eor	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	ret

<sink>:
               	add	x0, x0, x1, lsl #1
               	add	x1, x2, x2, lsl #1
               	add	x0, x0, x1
               	add	x0, x0, x3, lsl #2
               	ret

<forward>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, x0
               	add	x22, x20, #0x1
               	add	x16, x20, #0x2
               	str	x16, [sp, #0x68]
               	add	x23, x20, #0x3
               	add	x24, x20, #0x4
               	add	x16, x20, #0x5
               	str	x16, [sp, #0x60]
               	add	x25, x20, #0x6
               	add	x26, x20, #0x7
               	add	x27, x20, #0x8
               	add	x21, x20, #0x9
               	add	x28, x20, #0xa
               	add	x16, x20, #0xb
               	str	x16, [sp, #0x88]
               	add	x16, x20, #0xc
               	str	x16, [sp, #0x80]
               	add	x16, x20, #0xd
               	str	x16, [sp, #0x58]
               	add	x16, x20, #0xe
               	str	x16, [sp, #0x78]
               	add	x16, x20, #0xf
               	str	x16, [sp, #0x70]
               	bl	<addr>
               	add	x0, x20, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	add	x0, x0, x27
               	add	x0, x0, x21
               	add	x0, x0, x28
               	ldr	x17, [sp, #0x88]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x80]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x78]
               	add	x0, x0, x17
               	ldr	x17, [sp, #0x70]
               	add	x0, x0, x17
               	cbnz	w0, <addr>
               	mov	x0, #-0x1               // =-1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x2, x21
               	ldr	x0, [sp, #0x68]
               	ldr	x1, [sp, #0x60]
               	ldr	x3, [sp, #0x58]
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xa                // =10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	bl	<addr>
               	mov	x20, x0
               	mov	x1, x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	w20, #0xbf
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, eq
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
