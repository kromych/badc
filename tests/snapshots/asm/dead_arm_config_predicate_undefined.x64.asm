
dead_arm_config_predicate_undefined.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<dispatch>:
               	movq	(%rdi), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rcx
               	movq	(%rdi), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%rax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	leaq	(%rax), %rsi
               	movl	$0x1, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x2, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x3, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x4, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x5, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x6, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x7, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x8, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0x9, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xa, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xb, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xc, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xd, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xe, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rax, %rsi
               	movl	$0xf, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	%rsi, %rax
               	cmpq	$0xb0, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rdx
               	movslq	%edx, %rdx
               	movslq	%edx, %rdx
               	movq	(%rcx), %rax
               	andq	$0x8, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	%rdx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
