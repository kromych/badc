
attribute_cleanup.x64:	file format elf64-x86-64

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
               	subq	$0x70, %rsp
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x68(%rbp)
               	movl	$0x2, %edx
               	movl	%edx, -0x60(%rbp)
               	movl	$0x3, %esi
               	movl	%esi, -0x58(%rbp)
               	leaq	-0x58(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x60(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x68(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rcx
               	movl	$0x1, %edx
               	movl	%edx, (%rcx)
               	xorq	%rdx, %rdx
               	movl	%edx, -0x50(%rbp)
               	movslq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rdx)
               	movl	$0x2bc, %edi            # imm = 0x2BC
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rsi,%rdx,4)
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2bc, %rcx            # imm = 0x2BC
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x32, %ecx
               	movl	%ecx, -0x48(%rbp)
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	%edx, -0x40(%rbp)
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, (%rax)
               	movl	%edi, (%r8,%rsi,4)
               	jmp	<addr>
               	cmpq	$0x2, %rdx
               	je	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, (%rax)
               	movl	%edi, (%r8,%rsi,4)
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	cmpq	$0x3, %rdx
               	jl	<addr>
               	leaq	-0x48(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movslq	(%rax), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x1, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0x2, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0xc(%rcx), %rcx
               	cmpq	$0x32, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0xa, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0xb, %ecx
               	movl	%ecx, -0x30(%rbp)
               	movl	$0xc, %ecx
               	movl	%ecx, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x30(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	$0x3e7, %ecx            # imm = 0x3E7
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xc, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0xb, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0xa, %ecx
               	movl	%ecx, -0x38(%rbp)
               	movl	$0xb, %ecx
               	movl	%ecx, -0x30(%rbp)
               	movl	$0xc, %ecx
               	movl	%ecx, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x30(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x38(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	xorq	%rcx, %rcx
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0xc, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0xb, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x8(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x28, %ecx
               	movl	%ecx, -0x20(%rbp)
               	movl	$0x29, %ecx
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x20(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	$0x2a, %ecx
               	movslq	(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x29, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x28, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x28, %ecx
               	movl	%ecx, -0x20(%rbp)
               	movl	$0x29, %ecx
               	movl	%ecx, -0x18(%rbp)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x20(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	$0x2b, %ecx
               	movslq	(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x29, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x28, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x14, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x15, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	$0x1e, %ecx
               	movslq	(%rax), %rcx
               	cmpq	$0x2, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x15, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x14, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x14, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x15, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	movl	$0x1f, %ecx
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x15, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x70, %rsp
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
               	leaq	-0x40(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
