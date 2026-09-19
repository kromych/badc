
dead_arm_short_circuit_undefined.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorl	%edx, %edx
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorl	%edx, %edx
               	cmpq	$0x1, %rdx
               	xorl	%edx, %edx
               	movq	%rdx, (%rax)
               	movl	$0x2, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movl	$0x3, %esi
               	movq	%rsi, 0x8(%rax)
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%ecx, %ecx
               	cmpq	$0x1, %rcx
               	xorl	%edx, %edx
               	movq	%rdx, (%rax)
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x5, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	movq	(%rax), %rdx
               	andq	$0x1, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpq	$0x1, %rax
               	leaq	-0x10(%rbp), %rax
               	xorl	%edx, %edx
               	movq	%rdx, (%rax)
               	movl	$0x6, %esi
               	movq	%rsi, 0x8(%rax)
               	movq	%rcx, (%rax)
               	movl	$0x7, %esi
               	movq	%rsi, 0x8(%rax)
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	andq	$0x1, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%eax, %eax
               	cmpq	$0x1, %rax
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	andq	$0xff, %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	0x8(%rax), %rcx
               	andq	$0xff, %rcx
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	0x8(%rax), %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	jmp	<addr>
