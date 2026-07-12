
tail_call_args_from_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	lsl	x1, x1, #1
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x3, #2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<forward>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	add	x3, x0, #0x1
               	add	x1, x0, #0x2
               	add	x4, x0, #0x3
               	add	x5, x0, #0x4
               	add	x6, x0, #0x5
               	add	x7, x0, #0x6
               	add	x8, x0, #0x7
               	add	x9, x0, #0x8
               	add	x2, x0, #0x9
               	add	x10, x0, #0xa
               	add	x11, x0, #0xb
               	add	x12, x0, #0xc
               	add	x13, x0, #0xd
               	add	x14, x0, #0xe
               	add	x15, x0, #0xf
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x7
               	add	x0, x0, x8
               	add	x0, x0, x9
               	add	x0, x0, x2
               	add	x0, x0, x10
               	add	x0, x0, x11
               	add	x0, x0, x12
               	add	x0, x0, x14
               	add	x0, x0, x15
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	lsl	x0, x6, #1
               	add	x0, x1, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	lsl	x1, x13, #2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	cmp	x0, #0xbf
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
