
int128_scalar_result.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<via_variadic>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movsd	%xmm1, -0x90(%rbp,%riz)
               	movsd	%xmm2, -0x80(%rbp,%riz)
               	movsd	%xmm3, -0x70(%rbp,%riz)
               	movsd	%xmm4, -0x60(%rbp,%riz)
               	movsd	%xmm5, -0x50(%rbp,%riz)
               	movsd	%xmm6, -0x40(%rbp,%riz)
               	movsd	%xmm7, -0x30(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x250, %rsp            # imm = 0x250
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	leaq	-0xc8(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, 0x8(%rcx)
               	leaq	-0xd8(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	orq	%rax, %rdx
               	leaq	-0xe8(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x10(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	leaq	-0xf8(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	leaq	-0x108(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	orq	%rax, %rdx
               	leaq	-0x118(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x20(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	leaq	-0x10(%rbp), %rcx
               	leaq	-0x30(%rbp), %rdx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movl	$0x1, %edx
               	leaq	-0x128(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	movq	%rdx, %rdi
               	shlq	$0x24, %rdi
               	leaq	-0x138(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	movl	$0x3039, %r8d           # imm = 0x3039
               	leaq	(%rax,%r8), %rsi
               	cmpq	%rax, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdi
               	addq	%rcx, %rdi
               	leaq	-0x148(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	testq	%rsi, %rsi
               	seta	%cl
               	movzbq	%cl, %rcx
               	movq	%rsi, %r10
               	movq	%rax, %rsi
               	subq	%r10, %rsi
               	movq	%rdi, %r10
               	movq	%rax, %rdi
               	subq	%r10, %rdi
               	subq	%rcx, %rdi
               	leaq	-0x158(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	leaq	-0x40(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x168(%rbp), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rax, 0x8(%rcx)
               	shlq	$0x24, %rdx
               	leaq	-0x178(%rbp), %rcx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	(%rax,%r8), %rcx
               	cmpq	%rax, %rcx
               	setb	%al
               	movzbq	%al, %rax
               	addq	$0x0, %rdx
               	addq	%rax, %rdx
               	leaq	-0x188(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x2, %edi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	-0x40(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setl	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%r8, %rsi
               	orq	%rax, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%r8, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rsi
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	cmpq	%rdx, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	subq	%rdx, %rcx
               	movq	%rax, %r10
               	movq	%rsi, %rax
               	subq	%r10, %rax
               	movq	%rax, %rdx
               	subq	%rdi, %rdx
               	leaq	-0x1d8(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	xorq	%rax, %rax
               	xorq	%rax, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%rdi, %rcx
               	orq	%rax, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rax, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%rdi, %rcx
               	orq	%rax, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	popq	%rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	leaq	-0x80(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x10(%rbp), %rax
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x10, %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	-0x80(%rbp), %rax
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x80(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movslq	0x20(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x80(%rbp), %rax
               	movq	0x10(%rax), %rcx
               	movq	0x18(%rax), %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	xorq	%rsi, %rcx
               	xorq	%rdx, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x90(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	cmpq	%rdx, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%r8, %rax
               	movslq	(%rcx,%rax,4), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	cmpq	%rdx, %rax
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rdx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rsi, %rdi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	movq	%r8, %rdx
               	orq	%rax, %rdx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdi
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %r8
               	movq	0x8(%rax), %rax
               	xorq	%r8, %rsi
               	xorq	%rdi, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	movslq	(%rcx,%rax,4), %rax
               	cmpq	$0x1e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rdi, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6f, %eax
               	cmpq	$0x6f, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	leaq	-0x220(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	leaq	-0xa8(%rbp), %rdx
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	jmp	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	leaq	0x1(%rdx), %rsi
               	cmpq	%rdx, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	addq	$0x0, %rax
               	addq	%rax, %rdx
               	leaq	-0x230(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	%rdx, 0x8(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %rdx
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	$0x5, %rcx
               	xorq	$0x0, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rdx
               	movq	0x8(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rax
               	cmpq	%rcx, %rax
               	setb	%dil
               	movzbq	%dil, %rdi
               	cmpq	%rcx, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	movq	%rdi, %rcx
               	orq	%rax, %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	0x8(%rax), %rdx
               	leaq	-0x20(%rbp), %rax
               	movq	(%rax), %rdi
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rdx
               	setb	%r8b
               	movzbq	%r8b, %r8
               	cmpq	%rax, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	%rdi, %rsi
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rax
               	movq	%r8, %rdx
               	orq	%rax, %rdx
               	movslq	%ecx, %rax
               	cmpq	$0x1, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	movslq	%edx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rcx,%rdx), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x250, %rsp            # imm = 0x250
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xde, %eax
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
