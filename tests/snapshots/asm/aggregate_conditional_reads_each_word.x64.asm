
aggregate_conditional_reads_each_word.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<pick_pair>:
               	subq	$0x28, %rsp
               	testl	%esi, %esi
               	je	<addr>
               	leaq	(%rsp), %rax
               	movq	$0x4, (%rsp)
               	movq	$0x5, 0x8(%rsp)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
               	movq	$-0x4, 0x10(%rsp)
               	movq	$-0x5, 0x18(%rsp)
               	jmp	<addr>

<pick_triple>:
               	subq	$0x38, %rsp
               	testl	%esi, %esi
               	je	<addr>
               	leaq	(%rsp), %rax
               	movq	$0x2, (%rsp)
               	movq	$0x4, 0x8(%rsp)
               	movq	$0x6, 0x10(%rsp)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rax
               	imulq	$0xa, %rdx, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	addq	$0x38, %rsp
               	retq
               	leaq	0x18(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x0, 0x10(%rax)
               	jmp	<addr>

<main>:
               	pushq	%rax
               	movslq	<rip>, %rax # <addr>
               	movl	$0x5, %ecx
               	xorl	%edx, %edx
               	movl	<rip>, %esi # <addr>
               	testl	%esi, %esi
               	cmovlq	%rdx, %rcx
               	xorq	%rcx, %rax
               	movl	%eax, <rip> # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	testl	%eax, %eax
               	jl	<addr>
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x195, %rax            # imm = 0x195
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x4, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	cmpq	$-0x195, %rax           # imm = 0xFE6B
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	callq	<addr>
               	cmpq	$0x282, %rax            # imm = 0x282
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %edi
               	xorl	%esi, %esi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	movl	$0x2, %eax
               	popq	%r11
               	retq
