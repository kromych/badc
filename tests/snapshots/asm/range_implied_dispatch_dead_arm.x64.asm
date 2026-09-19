
range_implied_dispatch_dead_arm.x64:	file format elf64-x86-64

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
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx
               	movq	%rax, %rcx
               	movq	(%rdx), %rsi
               	addq	%rax, %rsi
               	movq	%rsi, (%rdx)
               	incq	%rcx
               	cmpl	$0x1, %eax
               	jb	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	xorq	$0x2, %rsi
               	testl	%esi, %esi
               	jne	<addr>
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	movl	(%rcx), %edx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	jb	<addr>
               	movl	$0x14, %edx
               	cmpl	$0x14, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movl	$0x2, (%rcx)
               	movl	(%rcx), %ecx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	movl	$0x14, %ecx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rsi
               	xorl	%edx, %edx
               	cmpq	$0x1092, %rsi           # imm = 0x1092
               	jne	<addr>
               	movq	%rax, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movq	$0x1092, (%rcx)         # imm = 0x1092
               	movq	(%rcx), %rcx
               	cmpq	$0x1092, %rcx           # imm = 0x1092
               	jne	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	movq	%rdx, %rax
               	retq
               	movq	%rdx, %rax
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0xa, %edx
               	jmp	<addr>
