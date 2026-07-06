
static_inline_function.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<bit_count>:
               	mov	x2, x0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x1               // =1
               	and	x0, x2, x17
               	add	x1, x1, x0
               	lsr	x2, x2, #1
               	cbnz	x2, <addr>
               	mov	x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xbeef             // =48879
               	movk	x0, #0xdead, lsl #16
               	bl	<addr>
               	cmp	x0, #0x18
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
