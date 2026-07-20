
runtime_array_member.x64:	file format elf64-x86-64

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
               	subq	$0x150, %rsp            # imm = 0x150
               	movl	$0xa, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x3, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x64, %rax
               	leaq	-0x20(%rbp), %rcx
               	movl	%eax, 0x10(%rcx)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0xd, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x6e, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	leaq	-0x38(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movslq	-0x8(%rbp), %rcx
               	leaq	-0x38(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x38(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movzbq	0x18(%rcx), %rdx
               	movb	%dl, 0x18(%rax)
               	movzbq	0x19(%rcx), %rdx
               	movb	%dl, 0x19(%rax)
               	movzbq	0x1a(%rcx), %rdx
               	movb	%dl, 0x1a(%rax)
               	movzbq	0x1b(%rcx), %rdx
               	movb	%dl, 0x1b(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	leaq	-0x58(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movl	$0x1, %eax
               	leaq	-0x58(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x2, %rcx
               	leaq	-0x58(%rbp), %rdx
               	movl	%ecx, 0x8(%rdx)
               	movl	$0x3, %edx
               	leaq	-0x58(%rbp), %rcx
               	movl	%edx, 0xc(%rcx)
               	movslq	-0x8(%rbp), %rcx
               	addq	$0x4, %rcx
               	leaq	-0x58(%rbp), %rdx
               	movl	%ecx, 0x10(%rdx)
               	movl	$0x5, %edx
               	leaq	-0x58(%rbp), %rcx
               	movl	%edx, 0x14(%rcx)
               	movl	$0x7, %edx
               	leaq	-0x58(%rbp), %rcx
               	movl	%edx, 0x18(%rcx)
               	leaq	-0x58(%rbp), %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x58(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movzbq	0x18(%rcx), %rdx
               	movb	%dl, 0x18(%rax)
               	movzbq	0x19(%rcx), %rdx
               	movb	%dl, 0x19(%rax)
               	movzbq	0x1a(%rcx), %rdx
               	movb	%dl, 0x1a(%rax)
               	movzbq	0x1b(%rcx), %rdx
               	movb	%dl, 0x1b(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	leaq	-0x78(%rbp), %rcx
               	movl	%eax, 0x18(%rcx)
               	leaq	-0x78(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x78(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x78(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movzbq	0x18(%rcx), %rdx
               	movb	%dl, 0x18(%rax)
               	movzbq	0x19(%rcx), %rdx
               	movb	%dl, 0x19(%rax)
               	movzbq	0x1a(%rcx), %rdx
               	movb	%dl, 0x1a(%rax)
               	movzbq	0x1b(%rcx), %rdx
               	movb	%dl, 0x1b(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x3, %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0xc(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x4, %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0x10(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x5, %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0x14(%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x6, %rax
               	leaq	-0x98(%rbp), %rcx
               	movl	%eax, 0x18(%rcx)
               	leaq	-0x98(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xb, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	$0xd, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xe, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x98(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	$0xf, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0x98(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movzbq	0x10(%rcx), %rdx
               	movb	%dl, 0x10(%rax)
               	movzbq	0x11(%rcx), %rdx
               	movb	%dl, 0x11(%rax)
               	movzbq	0x12(%rcx), %rdx
               	movb	%dl, 0x12(%rax)
               	movzbq	0x13(%rcx), %rdx
               	movb	%dl, 0x13(%rax)
               	popq	%rdx
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	leaq	-0xb0(%rbp), %rcx
               	movl	%eax, 0x10(%rcx)
               	movslq	-0x8(%rbp), %rax
               	leaq	-0xb0(%rbp), %rcx
               	movl	%eax, (%rcx)
               	movslq	-0x8(%rbp), %rax
               	addq	$0x2, %rax
               	leaq	-0xb0(%rbp), %rcx
               	movl	%eax, 0x4(%rcx)
               	leaq	-0xb0(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0xc, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	leaq	-0xb0(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0xb, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x150, %rsp            # imm = 0x150
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x150, %rsp            # imm = 0x150
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
