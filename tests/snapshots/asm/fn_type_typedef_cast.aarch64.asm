
fn_type_typedef_cast.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x0                // =0
               	ret

<caller>:
               	mov	x0, #0x0                // =0
               	ret

<next_fn>:
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x1, #0x5                // =5
               	stur	w1, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	bl	<addr>
               	sub	x1, x29, #0x8
               	cmp	x0, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
