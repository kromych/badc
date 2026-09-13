
long_double_libc_return.x64:	file format elf64-x86-64

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

<ldexpl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movsd	%xmm0, -0x20(%rbp,%riz)
               	movl	$0x35, %edi
               	fldt	-0x20(%rbp)
               	fstpl	-0x8(%rsp)
               	movsd	-0x8(%rsp), %xmm0
               	xorl	%eax, %eax
               	callq	<addr>
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %xmm0
               	movabsq	$0x45f0000000000000, %rax # imm = 0x45F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %xmm0
               	movabsq	$0x43f0000000000000, %rax # imm = 0x43F0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movl	$0x35, %edi
               	movq	%rax, %xmm0
               	callq	<addr>
               	movabsq	$0x4340000000000000, %rax # imm = 0x4340000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
