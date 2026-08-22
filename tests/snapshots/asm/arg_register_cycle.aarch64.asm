
arg_register_cycle.aarch64:	file format elf64-littleaarch64

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

<rec>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sxtw	x0, w0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	cbnz	x2, <addr>
               	sub	x0, x0, x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x2, #0x1
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x3               // =3
               	mov	x22, #0xa               // =10
               	mov	x20, #0x1               // =1
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x23, #0x2               // =2
               	mov	x0, x21
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	mov	x17, #0xfff9            // =65529
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x64               // =100
               	mov	x21, #0x3               // =3
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x17, #0xff9d            // =65437
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
