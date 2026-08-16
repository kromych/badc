
scoped_state_loop_dead_arm.x64:	file format elf64-x86-64

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

<work>:
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	retq

<main>:
               	xorq	%rdx, %rdx
               	movl	$0x3, %eax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	addq	%rcx, %rdi
               	movq	%rdi, (%rsi)
               	incq	%rdx
               	movl	%eax, %eax
               	cmpq	$0x2, %rax
               	jb	<addr>
               	cmpq	$0x3, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	movl	$0x1, %eax
               	xorq	%rsi, %rsi
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	jmp	<addr>
               	jmp	<addr>
               	movl	%eax, %esi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
