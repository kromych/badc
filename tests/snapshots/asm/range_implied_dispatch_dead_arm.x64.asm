
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
               	movq	%rcx, %rax
               	movq	%rcx, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	addq	%rdx, %r8
               	movq	%r8, (%rdi)
               	incq	%rsi
               	cmpq	$0x1, %rdx
               	jb	<addr>
               	movl	$0x2, %eax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movl	%eax, %edx
               	movq	%rdx, %rdi
               	xorq	$0x2, %rdi
               	movl	%edi, %edi
               	testq	%rdi, %rdi
               	jne	<addr>
               	cmpq	$0x2, %rsi
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
               	movl	%ecx, %ecx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
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
               	movl	%ecx, %ecx
               	andq	$0x1, %rcx
               	cmpq	$0x1, %rcx
               	jb	<addr>
               	movl	$0x14, %ecx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	movq	(%rcx), %rcx
               	xorq	%rdx, %rdx
               	cmpq	$0x1092, %rcx           # imm = 0x1092
               	jne	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rcx
               	movl	$0x1092, %esi           # imm = 0x1092
               	movq	%rsi, (%rcx)
               	movq	(%rcx), %rcx
               	cmpq	$0x1092, %rcx           # imm = 0x1092
               	jne	<addr>
               	movq	%rax, %rdx
               	movslq	%edx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
