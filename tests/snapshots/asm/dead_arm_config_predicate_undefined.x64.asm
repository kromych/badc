
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

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

<dispatch>:
               	movq	(%rdi), %rax
               	movq	%rax, %rcx
               	andq	$0x1, %rcx
               	addq	$0xa, %rcx
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorl	%edx, %edx
               	leaq	-0x8(%rbp), %rax
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rsi
               	andq	$0x1, %rsi
               	addq	$0xa, %rsi
               	movq	%rcx, %rdi
               	andq	$0x8, %rdi
               	testl	%edi, %edi
               	setne	%dil
               	movzbq	%dil, %rdi
               	movslq	%edi, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	addq	%rsi, %rcx
               	movslq	%ecx, %rcx
               	leaq	0xa(%rcx), %rsi
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0x3, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0x6, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x7, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0x8, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0x9, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xa, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xb, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0xc, %ecx
               	leaq	-0x8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rsi
               	movl	$0xe, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	movq	%rcx, %rax
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movl	$0xf, %eax
               	leaq	-0x8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rax, %rdx
               	andq	$0x1, %rdx
               	addq	$0xa, %rdx
               	andq	$0x8, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	$0x0, (%rax)
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorl	%eax, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
