
ssa_bail_fixup_rollback.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<ld32>:
               	movzbq	0x3(%rdi), %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x2(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	0x1(%rdi), %rcx
               	orq	%rcx, %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	movl	%eax, %eax
               	movzbq	(%rdi), %rcx
               	orq	%rcx, %rax
               	retq

<core>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	xorq	%r8, %r8
               	movslq	%r8d, %rax
               	cmpq	$0x4, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%r8d, %rax
               	leaq	0x1(%rax), %r8
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	leaq	(%r8,%r8,4), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rcx, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x1(%r8), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rdx, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0x6(%r8), %r9
               	movslq	%r9d, %r9
               	movq	%r8, %rbx
               	shlq	$0x2, %rbx
               	movslq	%ebx, %rbx
               	addq	%rsi, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	leaq	-0x40(%rbp), %rax
               	leaq	0xb(%r8), %r9
               	movslq	%r9d, %r9
               	leaq	0x10(%rdx), %rbx
               	movq	%r8, %r12
               	shlq	$0x2, %r12
               	movslq	%r12d, %r12
               	addq	%r12, %rbx
               	movzbq	0x3(%rbx), %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x2(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	0x1(%rbx), %r13
               	orq	%r13, %r12
               	movl	%r12d, %r12d
               	shlq	$0x8, %r12
               	movl	%r12d, %r12d
               	movzbq	(%rbx), %rbx
               	orq	%r12, %rbx
               	movl	%ebx, (%rax,%r9,4)
               	jmp	<addr>
               	xorq	%rax, %rax
               	leaq	-0x40(%rbp), %rcx
               	movl	(%rcx), %ecx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x14(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x28(%rdx), %edx
               	xorq	%rdx, %rcx
               	leaq	-0x40(%rbp), %rdx
               	movl	0x3c(%rdx), %edx
               	xorq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq

<stream_xor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rdi, %r12
               	movq	%r8, %rbx
               	movq	%rdx, %r14
               	movq	%rsi, %r13
               	testq	%r14, %r14
               	jne	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rdx, %rdx
               	movl	%edx, %eax
               	cmpq	$0x10, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%edx, %eax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, %esi
               	addq	%rsi, %rax
               	xorq	%rsi, %rsi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movl	%edx, %eax
               	cmpq	$0x8, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%edx, %eax
               	leaq	0x1(%rax), %rdx
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	%edx, %esi
               	addq	%rsi, %rax
               	addq	%rcx, %rsi
               	movzbq	(%rsi), %rsi
               	movb	%sil, (%rax)
               	jmp	<addr>
               	cmpq	$0x40, %r14
               	jb	<addr>
               	leaq	-0x50(%rbp), %rdi
               	leaq	-0x10(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdx
               	callq	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, %eax
               	cmpq	$0x40, %rax
               	jae	<addr>
               	jmp	<addr>
               	movl	%ecx, %eax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	movl	%ecx, %eax
               	addq	%r12, %rax
               	testq	%r13, %r13
               	je	<addr>
               	jmp	<addr>
               	subq	$0x40, %r14
               	addq	$0x40, %r12
               	testq	%r13, %r13
               	je	<addr>
               	jmp	<addr>
               	movl	%ecx, %edx
               	addq	%r13, %rdx
               	movzbq	(%rdx), %rsi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	leaq	-0x50(%rbp), %rdx
               	movl	%ecx, %edi
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	addq	$0x40, %r13
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	movslq	%ecx, %rax
               	cmpq	$0x20, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rax
               	leaq	0x1(%rax), %rcx
               	jmp	<addr>
               	leaq	-0x68(%rbp), %rax
               	movslq	%ecx, %rdx
               	addq	%rdx, %rax
               	andq	$0xff, %rdx
               	movb	%dl, (%rax)
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorq	%rsi, %rsi
               	movl	$0x40, %edx
               	leaq	-0x48(%rbp), %rcx
               	leaq	-0x68(%rbp), %r8
               	callq	<addr>
               	leaq	-0x40(%rbp), %rax
               	movzbq	(%rax), %rax
               	xorq	$0x4d, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
