
libc_math_hyperbolic.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	subsd	%xmm1, %xmm0
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	subsd	%xmm1, %xmm0
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm2
               	comisd	%xmm0, %xmm2
               	ja	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movapd	%xmm1, %xmm0
               	callq	<addr>
               	xorps	%xmm1, %xmm1
               	subsd	%xmm1, %xmm0
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	callq	<addr>
               	movsd	<rip>, %xmm1
               	subsd	%xmm1, %xmm0
               	xorps	%xmm1, %xmm1
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	xorps	%xmm1, %xmm1
               	subsd	%xmm1, %xmm0
               	comisd	%xmm0, %xmm1
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorps	%xmm0, %xmm0
               	callq	<addr>
               	cvtss2sd	%xmm0, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm15
               	subsd	%xmm15, %xmm0
               	movq	%rax, %xmm15
               	comisd	%xmm0, %xmm15
               	jbe	<addr>
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	<rip>, %xmm1
               	comisd	%xmm0, %xmm1
               	ja	<addr>
               	movl	$0x8, %eax
               	popq	%rbp
               	retq
               	popq	%rbp
               	retq
