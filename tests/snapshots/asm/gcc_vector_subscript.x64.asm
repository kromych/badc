
gcc_vector_subscript.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x28(%rbp), %rdx
               	movl	%eax, %ecx
               	addq	%rcx, %rdx
               	movzbq	(%rdx), %rdx
               	andq	$0xff, %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movl	%eax, %eax
               	incq	%rax
               	movl	%eax, %ecx
               	cmpq	$0x10, %rcx
               	jb	<addr>
               	leaq	-0x28(%rbp), %rax
               	movl	$0x63, %ecx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x28(%rbp), %rax
               	movl	$0xc8, %ecx
               	movb	%cl, 0xa(%rax)
               	leaq	-0x28(%rbp), %rax
               	movzbq	0x3(%rax), %rax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movzbq	0xa(%rax), %rax
               	xorq	$0xc8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x18(%rbp), %rax
               	movl	$0x7530, %ecx           # imm = 0x7530
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	0x8(%rax), %eax
               	xorq	$0x7530, %rax           # imm = 0x7530
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	leaq	(%rax), %rcx
               	movl	(%rcx), %ecx
               	addq	$0x0, %rcx
               	movl	%ecx, %ecx
               	movl	0x4(%rax), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	0x8(%rax), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	movl	0xc(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %eax
               	xorq	$0x9088, %rax           # imm = 0x9088
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
