
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
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rcx
               	xorq	%rdx, %rdx
               	movl	%edx, (%rcx)
               	movl	$0x1, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	$0x2, %esi
               	movl	%esi, -0x18(%rbp)
               	movl	$0x3, %edi
               	movl	%edi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rax,4)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rax,4)
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	movl	$0x1, %esi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rsp), %rbx
               	movq	%rsi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rax
               	movl	%esi, (%rax)
               	movl	%edx, -0x8(%rbp)
               	movslq	(%rax), %rax
               	leaq	<rip>, %rdx
               	xorq	%rsi, %rsi
               	movl	%esi, (%rdx)
               	movl	$0x2bc, %edi            # imm = 0x2BC
               	leaq	<rip>, %rsi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rcx)
               	movl	%edi, (%rsi,%rdx,4)
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	(%rcx), %rax
               	cmpl	$0x1, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	movl	$0x32, %edx
               	movl	%edx, -0x18(%rbp)
               	jmp	<addr>
               	movl	%eax, -0x10(%rbp)
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rdx,4)
               	jmp	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rdx,4)
               	movslq	%eax, %rax
               	incq	%rax
               	cmpl	$0x3, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%edx, (%rdi,%rax,4)
               	movslq	(%rcx), %rax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x1, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpl	$0x2, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0xc(%rdx), %rdx
               	cmpl	$0x32, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, (%rcx)
               	movl	$0xa, %edx
               	movl	%edx, -0x20(%rbp)
               	movl	$0xb, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0xc, %edx
               	movl	%edx, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	movslq	(%rdx), %rdi
               	leaq	<rip>, %r8
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rcx)
               	movl	%edi, (%r8,%rdx,4)
               	movslq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rdx,4)
               	leaq	-0x20(%rbp), %rdi
               	movslq	(%rdi), %rsi
               	leaq	<rip>, %r8
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rcx)
               	movl	%esi, (%r8,%rdx,4)
               	movl	$0x3e7, %edx            # imm = 0x3E7
               	movslq	(%rcx), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0xc, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0xb, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x8(%rax), %rax
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rsi, %rsi
               	movl	%esi, (%rcx)
               	movl	$0xa, %eax
               	movl	%eax, -0x20(%rbp)
               	movl	$0xb, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0xc, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, (%rcx)
               	movl	%edx, (%r8,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, (%rcx)
               	movl	%edx, (%r8,%rax,4)
               	movslq	(%rdi), %rdx
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%edx, (%rdi,%rax,4)
               	movq	%rsi, %rax
               	movslq	(%rcx), %rax
               	cmpl	$0x3, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0xc, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0xb, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x8(%rdx), %rdx
               	cmpl	$0xa, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%esi, (%rcx)
               	movl	$0x28, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0x29, %esi
               	movl	%esi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rdi
               	movslq	(%rdi), %r8
               	leaq	<rip>, %r9
               	movslq	(%rcx), %rdi
               	leaq	0x1(%rdi), %rbx
               	movl	%ebx, (%rcx)
               	movl	%r8d, (%r9,%rdi,4)
               	leaq	-0x18(%rbp), %rdi
               	movslq	(%rdi), %r8
               	leaq	<rip>, %r9
               	movslq	(%rcx), %rdi
               	leaq	0x1(%rdi), %rbx
               	movl	%ebx, (%rcx)
               	movl	%r8d, (%r9,%rdi,4)
               	movl	$0x2a, %edi
               	movslq	(%rcx), %rdi
               	cmpl	$0x2, %edi
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x29, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x28, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdi, %rdi
               	movl	%edi, (%rcx)
               	movl	%edx, -0x18(%rbp)
               	movl	%esi, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rsi
               	movslq	(%rsi), %rdx
               	leaq	<rip>, %r8
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r9
               	movl	%r9d, (%rcx)
               	movl	%edx, (%r8,%rax,4)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %rdx
               	leaq	<rip>, %r9
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, (%rcx)
               	movl	%edx, (%r9,%rax,4)
               	movl	$0x2b, %eax
               	movslq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rdx
               	cmpl	$0x29, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx
               	movslq	0x4(%rdx), %rdx
               	cmpl	$0x28, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%edi, (%rcx)
               	movl	$0x14, %edx
               	movl	%edx, -0x18(%rbp)
               	movl	$0x15, %edx
               	movl	%edx, -0x10(%rbp)
               	movslq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r9
               	movl	%r9d, (%rcx)
               	movl	%esi, (%rdi,%rdx,4)
               	movslq	(%r8), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rdx
               	leaq	0x1(%rdx), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rdx,4)
               	movl	$0x1e, %edx
               	movslq	(%rcx), %rdx
               	cmpl	$0x2, %edx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, (%rcx)
               	movl	$0x14, %eax
               	movl	%eax, -0x18(%rbp)
               	movl	$0x15, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rax,4)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rsi
               	leaq	<rip>, %rdi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %r8
               	movl	%r8d, (%rcx)
               	movl	%esi, (%rdi,%rax,4)
               	movl	$0x1f, %eax
               	movslq	(%rcx), %rax
               	cmpl	$0x2, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x15, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x14, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rsp), %rbx
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movslq	(%rax), %rdx
               	leaq	<rip>, %rsi
               	movslq	(%rcx), %rax
               	leaq	0x1(%rax), %rdi
               	movl	%edi, (%rcx)
               	movl	%edx, (%rsi,%rax,4)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
               	movq	%rsi, %rax
               	jmp	<addr>
