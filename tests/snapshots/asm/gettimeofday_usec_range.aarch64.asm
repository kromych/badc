
gettimeofday_usec_range.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x370              // =880
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x60]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x0, lt
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	cset	x0, ge
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x64
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x60
               	ret
               	b	<addr>
