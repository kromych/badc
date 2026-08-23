
attribute_cleanup.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rax
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movl	$0x1, %ecx
               	movl	%ecx, -0x18(%rbp)
               	movl	$0x2, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x3, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edx, (%rdi,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edx, (%rdi,%rcx,4)
               	leaq	-0x18(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edx, (%rdi,%rcx,4)
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	movl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x3, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0x2, %rcx
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
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	%esi, (%rax)
               	leaq	<rip>, %rcx
               	movl	%edx, (%rcx)
               	movl	%esi, -0x8(%rbp)
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rcx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rcx)
               	movl	$0x2bc, %edi            # imm = 0x2BC
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edi, (%rsi,%rcx,4)
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
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
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	movl	$0x32, %edx
               	movl	%edx, -0x10(%rbp)
               	jmp	<addr>
               	movl	%edx, -0x8(%rbp)
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rsi
               	movslq	(%rsi), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rax), %rsi
               	leaq	0x1(%rsi), %r9
               	movl	%r9d, (%rax)
               	movl	%edi, (%r8,%rsi,4)
               	jmp	<addr>
               	cmpq	$0x2, %rdx
               	je	<addr>
               	leaq	-0x8(%rbp), %rsi
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
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edx, (%rdi,%rcx,4)
               	movslq	(%rax), %rcx
               	cmpq	$0x4, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x1, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpq	$0x2, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0xc(%rdx), %rdx
               	cmpq	$0x32, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0xa, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0xb, %edx
               	movl	%edx, -0x10(%rbp)
               	movl	$0xc, %edx
               	movl	%edx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rax)
               	movl	%edi, (%r8,%rdx,4)
               	movslq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movl	%esi, (%rdi,%rdx,4)
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	leaq	<rip>, %r8
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rax)
               	movl	%esi, (%r8,%rdx,4)
               	movl	$0x3e7, %edx            # imm = 0x3E7
               	movslq	(%rax), %rdx
               	cmpq	$0x3, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xc, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	0x4(%rcx), %rcx
               	cmpq	$0xb, %rcx
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
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movl	$0xa, %ecx
               	movl	%ecx, -0x18(%rbp)
               	movl	$0xb, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0xc, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r9
               	movl	%r9d, (%rax)
               	movl	%edx, (%r8,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r9
               	movl	%r9d, (%rax)
               	movl	%edx, (%r8,%rcx,4)
               	movslq	(%rdi), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%edx, (%rdi,%rcx,4)
               	movq	%rsi, %rcx
               	movslq	(%rax), %rcx
               	cmpq	$0x3, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0xc, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0xb, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpq	$0xa, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	%esi, (%rax)
               	movl	$0x28, %edi
               	movl	%edi, -0x10(%rbp)
               	movl	$0x29, %r8d
               	movl	%r8d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	<rip>, %r9
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rbx
               	movl	%ebx, (%rax)
               	movl	%esi, (%r9,%rdx,4)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	<rip>, %r9
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %rbx
               	movl	%ebx, (%rax)
               	movl	%esi, (%r9,%rdx,4)
               	movl	$0x2a, %edx
               	movslq	(%rax), %rdx
               	cmpq	$0x2, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x29, %rcx
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
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, (%rax)
               	movl	%edi, -0x10(%rbp)
               	movl	%r8d, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rdi
               	movslq	(%rdi), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r9
               	movl	%r9d, (%rax)
               	movl	%edx, (%r8,%rcx,4)
               	leaq	-0x10(%rbp), %r8
               	movslq	(%r8), %rdx
               	leaq	<rip>, %r9
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rbx
               	movl	%ebx, (%rax)
               	movl	%edx, (%r9,%rcx,4)
               	movl	$0x2b, %ecx
               	movslq	(%rax), %rcx
               	cmpq	$0x2, %rcx
               	movl	$0x1, %ecx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpq	$0x29, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpq	$0x28, %rdx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	%esi, (%rax)
               	movl	$0x14, %edx
               	movl	%edx, -0x10(%rbp)
               	movl	$0x15, %edx
               	movl	%edx, -0x8(%rbp)
               	movslq	(%rdi), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rax)
               	movl	%esi, (%rdi,%rdx,4)
               	movslq	(%r8), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rax)
               	movl	%esi, (%rdi,%rdx,4)
               	movl	$0x1e, %edx
               	movslq	(%rax), %rdx
               	cmpq	$0x2, %rdx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x15, %rcx
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
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, (%rax)
               	movl	$0x14, %ecx
               	movl	%ecx, -0x10(%rbp)
               	movl	$0x15, %ecx
               	movl	%ecx, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%esi, (%rdi,%rcx,4)
               	leaq	-0x10(%rbp), %rcx
               	movslq	(%rcx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %r8
               	movl	%r8d, (%rax)
               	movl	%esi, (%rdi,%rcx,4)
               	movl	$0x1f, %ecx
               	movslq	(%rax), %rax
               	cmpq	$0x2, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x15, %rax
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
               	movq	(%rsp), %rbx
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	-0x8(%rbp), %rcx
               	movslq	(%rcx), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movl	%edi, (%rax)
               	movl	%edx, (%rsi,%rcx,4)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
