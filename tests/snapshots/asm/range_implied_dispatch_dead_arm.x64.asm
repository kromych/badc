
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
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movl	(%rax), %edx
               	andq	$0x1, %rdx
               	cmpl	$0x1, %edx
               	jb	<addr>
               	movl	$0x2, (%rax)
               	movl	(%rax), %eax
               	andq	$0x1, %rax
               	cmpl	$0x1, %eax
               	jb	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	movq	(%rax), %rax
               	cmpq	$0x1092, %rax           # imm = 0x1092
               	jne	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	$0x1092, (%rax)         # imm = 0x1092
               	movq	(%rax), %rax
               	cmpq	$0x1092, %rax           # imm = 0x1092
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	movl	$0x3, %eax
               	retq
