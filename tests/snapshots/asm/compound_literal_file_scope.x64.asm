
compound_literal_file_scope.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movq	(%rax), %rcx
               	addq	$0x4, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x4, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x8, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x72, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %rax
               	xorq	$0x6f, %rax
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x10, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
