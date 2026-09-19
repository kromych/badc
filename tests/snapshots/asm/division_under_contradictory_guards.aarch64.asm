
division_under_contradictory_guards.aarch64:	file format elf64-littleaarch64

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

<sdiv_dead>:
               	cmp	w1, #0x5
               	mov	x0, #0x7                // =7
               	ret

<udiv_dead>:
               	mov	x0, #0x7                // =7
               	ret

<srem_dead>:
               	mov	x0, #0x7                // =7
               	ret

<urem_dead>:
               	cmp	w1, #0x5
               	mov	x0, #0x7                // =7
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x7                // =7
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	mov	x0, #0x7                // =7
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
