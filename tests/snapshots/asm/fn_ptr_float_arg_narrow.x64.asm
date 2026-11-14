
fn_ptr_float_arg_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<scale2>:
               	movss	<rip>, %xmm1
               	mulss	%xmm1, %xmm0
               	retq

<negf>:
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	retq

<addf>:
               	addss	%xmm1, %xmm0
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	movss	<rip>, %xmm0
               	movss	<rip>, %xmm1
               	callq	<addr>
               	movss	<rip>, %xmm1
               	ucomiss	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
