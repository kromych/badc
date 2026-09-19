
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
               	xorq	%rax, %rax
               	leaq	<rip>, %rsi
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	(%rsi), %rcx
               	addq	%rax, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rdx
               	cmpl	$0x1, %eax
               	jb	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	xorq	$0x2, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x2, %rdx
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
               	movl	(%rcx), %ecx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	movl	$0x14, %ecx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x2, %edx
               	movl	%edx, (%rcx)
               	movl	(%rcx), %ecx
               	andq	$0x1, %rcx
               	cmpl	$0x1, %ecx
               	jb	<addr>
               	movl	$0x14, %ecx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rdx
               	xorq	%rcx, %rcx
               	cmpq	$0x1092, %rdx           # imm = 0x1092
               	jne	<addr>
               	movq	%rax, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rdx
               	movl	$0x1092, %esi           # imm = 0x1092
               	movq	%rsi, (%rdx)
               	movq	(%rdx), %rdx
               	cmpq	$0x1092, %rdx           # imm = 0x1092
               	jne	<addr>
               	movq	%rax, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
