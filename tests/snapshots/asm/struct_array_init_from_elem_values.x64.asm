
struct_array_init_from_elem_values.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movl	$0x20, %eax
               	leaq	-0x20(%rbp), %rcx
               	movw	%ax, (%rcx)
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rcx
               	movw	%ax, 0x4(%rcx)
               	leaq	-0x8(%rbp), %rdx
               	leaq	-0x20(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x30(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x21, %ecx
               	leaq	-0x30(%rbp), %rdx
               	movw	%cx, (%rdx)
               	leaq	-0x30(%rbp), %rcx
               	movw	%ax, 0x2(%rcx)
               	movl	$0x4, %edx
               	leaq	-0x30(%rbp), %rcx
               	movw	%dx, 0x4(%rcx)
               	leaq	-0x10(%rbp), %rdx
               	leaq	-0x30(%rbp), %rcx
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	leaq	-0x20(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x30(%rbp), %rcx
               	leaq	-0x50(%rbp), %rdx
               	addq	$0x10, %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x50(%rbp), %rcx
               	movzwq	(%rcx), %rcx
               	xorq	$0x20, %rcx
               	movl	%ecx, %ecx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movzwq	0x4(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rax
               	leaq	-0x8(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movzwq	0x10(%rax), %rax
               	xorq	$0x21, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movzwq	0x12(%rax), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movq	0x18(%rax), %rax
               	leaq	-0x10(%rbp), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x58(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x1, %ecx
               	leaq	-0x68(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	movl	$0x2, %edx
               	leaq	-0x68(%rbp), %rax
               	movl	%edx, 0xc(%rax)
               	leaq	-0x68(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x88(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
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
