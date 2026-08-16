
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
               	xorq	%rcx, %rcx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movl	%eax, %edi
               	addq	%rdi, %rsi
               	movq	%rsi, (%rdx)
               	incq	%rcx
               	movl	%eax, %eax
               	cmpq	$0x1, %rax
               	jb	<addr>
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	%eax, %edx
               	xorq	$0x2, %rdx
               	movl	%edx, %edx
               	testq	%rdx, %rdx
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
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	jb	<addr>
               	movl	$0x14, %eax
               	cmpq	$0x14, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x2, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %eax
               	movl	%eax, %eax
               	andq	$0x1, %rax
               	cmpq	$0x1, %rax
               	jb	<addr>
               	movl	$0x14, %eax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	cmpq	$0x1092, %rcx           # imm = 0x1092
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1092, %ecx           # imm = 0x1092
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	cmpq	$0x1092, %rcx           # imm = 0x1092
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
