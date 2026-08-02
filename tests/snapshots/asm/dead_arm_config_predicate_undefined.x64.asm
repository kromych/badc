
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
               	movslq	%eax, %rax
               	movq	(%rdi), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	xorq	%rcx, %rcx
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
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leaq	(%rax), %rdx
               	movl	$0x1, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x2, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x3, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x4, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x5, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x6, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x7, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x8, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0x9, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xa, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xb, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xc, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xd, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xe, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movl	$0xf, %eax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movq	(%rcx), %rax
               	andq	$0x1, %rax
               	addq	$0xa, %rax
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	addq	%rdx, %rax
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
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
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
               	movslq	%eax, %rax
               	movq	(%rcx), %rcx
               	andq	$0x8, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
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
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
