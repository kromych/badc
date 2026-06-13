
struct_array_elided_runtime.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<run>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	popq	%r11
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	movq	%rdi, %rax
               	incq	%rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movq	%rdi, %rax
               	addq	$0x2, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	movq	%rdi, %rax
               	addq	$0x3, %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	movq	%rdi, %rcx
               	incq	%rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	movq	%rdi, %rcx
               	addq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	movq	0x8(%rcx), %r11
               	movq	%r11, 0x8(%rax)
               	movq	0x10(%rcx), %r11
               	movq	%r11, 0x10(%rax)
               	popq	%r11
               	leaq	-0x28(%rbp), %rax
               	movl	%edi, (%rax)
               	movl	$0x2, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movq	%rdi, %rax
               	addq	$0x3, %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	movq	%rdi, %rax
               	addq	$0x4, %rax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	movl	$0x7, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x10(%rcx)
               	movl	$0x8, %eax
               	leaq	-0x28(%rbp), %rcx
               	movl	%eax, 0x14(%rcx)
               	leaq	-0x28(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	movq	%rdi, %rcx
               	addq	$0x3, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	movq	%rdi, %rcx
               	addq	$0x4, %rcx
               	movslq	%ecx, %rcx
               	cmpq	%rcx, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x28(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x7, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x28(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	xorq	%rbx, %rbx
               	movslq	%ebx, %rax
               	cmpq	$0x14, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ebx, %rax
               	movq	%rax, %rbx
               	incq	%rbx
               	jmp	<addr>
               	movslq	%ebx, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %rax
               	incq	%rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
