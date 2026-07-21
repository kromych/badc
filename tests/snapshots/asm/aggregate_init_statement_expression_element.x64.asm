
aggregate_init_statement_expression_element.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_nested_aggregate>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movl	%edi, (%rax)
               	movl	$0x7, %ecx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	leaq	0x1(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	0x2(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	0x3(%rdi), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	0x8(%rax), %eax
               	addq	%rcx, %rax
               	movl	%eax, %ecx
               	leaq	-0x10(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x10(%rbp), %rax
               	movl	(%rax), %eax
               	movl	%edi, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	leaq	(%rdi,%rdi,2), %rax
               	addq	$0x6, %rax
               	movslq	%eax, %rax
               	movl	%eax, %eax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movl	$0x1000, %edx           # imm = 0x1000
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	movzbq	0xa(%rcx), %rdx
               	movb	%dl, 0xa(%rax)
               	movzbq	0xb(%rcx), %rdx
               	movb	%dl, 0xb(%rax)
               	popq	%rdx
               	movl	$0xa1b2c3d4, %eax       # imm = 0xA1B2C3D4
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x2, %ecx
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x1000, %eax           # imm = 0x1000
               	movl	$0x1030, %ecx           # imm = 0x1030
               	leaq	-0x20(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %eax
               	movl	$0xa1b2c3d4, %r11d      # imm = 0xA1B2C3D4
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	leaq	-0x50(%rbp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movzbq	0x8(%rdx), %rax
               	movb	%al, 0x8(%rcx)
               	movzbq	0x9(%rdx), %rax
               	movb	%al, 0x9(%rcx)
               	movzbq	0xa(%rdx), %rax
               	movb	%al, 0xa(%rcx)
               	movzbq	0xb(%rdx), %rax
               	movb	%al, 0xb(%rcx)
               	popq	%rax
               	leaq	-0x50(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x15, %ecx
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0x4(%rax)
               	movl	$0x1e, %ecx
               	leaq	-0x50(%rbp), %rax
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	-0x50(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0x1e, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	0x4(%rax), %eax
               	xorq	$0x2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movl	0x8(%rax), %eax
               	cmpq	$0x1030, %rax           # imm = 0x1030
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
