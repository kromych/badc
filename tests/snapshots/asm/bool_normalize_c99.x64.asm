
bool_normalize_c99.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2

<ret_bool>:
               	movslq	%edi, %rdi
               	cmpq	$0x0, %rdi
               	setne	%al
               	movzbq	%al, %rax
               	retq

<take_bool>:
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	jmp	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	cmpq	$0x1, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	cmpq	$0x0, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	cmpq	$0x1, %r14
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	$0xff, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	xorq	%rcx, %rcx
               	movq	%rax, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	andq	$0xff, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movl	$0x1, %ecx
               	movb	%cl, (%rax)
               	leaq	-0x58(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x58(%rbp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, 0x8(%rax)
               	leaq	-0x58(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x58(%rbp), %rax
               	movzbq	0x8(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorq	%rcx, %rcx
               	movl	$0x1, %esi
               	movb	%sil, (%rax)
               	leaq	-0x60(%rbp), %rax
               	movb	%cl, 0x1(%rax)
               	leaq	-0x60(%rbp), %rax
               	movb	%sil, 0x2(%rax)
               	leaq	-0x60(%rbp), %rax
               	movzbq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	0x1(%rax), %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	0x2(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	cmpq	$0x0, %rsi
               	je	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rax
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	$0xff, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	xorq	%rcx, %rcx
               	cmpq	$0x0, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	$0x0, %rdx
               	jne	<addr>
               	movq	%rcx, %rdx
               	cmpq	$0x0, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0xc0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
