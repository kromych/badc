
branch_fuse_short_circuit.x64:	file format elf64-x86-64

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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	leaq	<rip>, %r9
               	movl	(%r9), %ecx
               	cmpq	$-0x1, %rsi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%r8, %r8
               	jne	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x1, %ecx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rdx), %rcx
               	movq	(%rdi), %rdx
               	movl	(%r9), %edx
               	cmpq	$-0x1, %rcx
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	leaq	<rip>, %rcx
               	movl	(%rcx), %esi
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	movl	(%rcx), %ecx
               	cmpq	$-0x1, %rdi
               	jne	<addr>
               	cmpq	$0x64, %rdi
               	jbe	<addr>
               	movl	$0x2, %ecx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rsi), %rcx
               	movq	(%rdx), %rdx
               	cmpq	$-0x1, %rcx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x64, %rcx
               	jbe	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpq	$0x64, %rsi
               	jbe	<addr>
               	movl	$0x2, %ecx
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
