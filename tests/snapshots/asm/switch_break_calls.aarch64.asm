
switch_break_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x64               // =100
               	ret

<f2>:
               	mov	x0, #0xc8               // =200
               	ret

<f3>:
               	mov	x0, #0x12c              // =300
               	ret

<f4>:
               	mov	x0, #0x190              // =400
               	ret

<driver>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x20, [sp]
               	mov	x20, x0
               	sxtw	x20, w20
               	cmp	x20, #0x1
               	b.lt	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	ldr	x20, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	bl	<addr>
               	mov	x20, x0
               	b	<addr>
               	cmp	x20, #0x0
               	b.eq	<addr>
               	b	<addr>
               	cmp	x20, #0x2
               	b.lt	<addr>
               	b	<addr>
               	cmp	x20, #0x1
               	b.eq	<addr>
               	b	<addr>
               	cmp	x20, #0x2
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
