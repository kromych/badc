
gcc_vector_size_attribute.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<identity>:
               	popq	%r10
               	subq	$0x10, %rsp
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0xd0(%rbp)
               	movq	%rdx, -0xc8(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	leaq	-0x30(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x30(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0x7(%rcx), %rax
               	xorq	$0x8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x10, %rcx
               	jl	<addr>
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x68(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x68(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x80(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x10, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0x1, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xa0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xa0(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	leaq	-0xb8(%rbp), %rax
               	leaq	-0xa0(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0xb8(%rbp), %rcx
               	movzbq	(%rcx), %rax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzbq	0xf(%rcx), %rax
               	xorq	$0xa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x7, %eax
               	addq	$0x110, %rsp            # imm = 0x110
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
