
vector_object_alignment.x64:	file format elf64-x86-64

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

<file_scope_objects>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x10, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x12, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	0x10(%rcx), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x10, %rcx
               	je	<addr>
               	movl	$0x13, %eax
               	retq
               	leaq	<rip>, %rcx
               	leaq	0x20(%rcx), %rdx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	cmpq	$0x20, %rcx
               	je	<addr>
               	movl	$0x14, %eax
               	retq
               	movl	$0x3, %ecx
               	movw	%cx, 0x2(%rax)
               	leaq	<rip>, %rcx
               	movl	$0x5, %edx
               	movl	%edx, 0xc(%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x7, %esi
               	movl	%esi, 0x1c(%rdx)
               	leaq	<rip>, %rsi
               	movl	$0xb, %edi
               	movl	%edi, 0x10(%rsi)
               	leaq	<rip>, %rdi
               	movl	$0xd, %r8d
               	movl	%r8d, 0x24(%rdi)
               	movswq	0x2(%rax), %rax
               	movslq	0xc(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	0x1c(%rdx), %rcx
               	addq	%rcx, %rax
               	movslq	0x10(%rsi), %rcx
               	addq	%rcx, %rax
               	addq	$0xd, %rax
               	cmpl	$0x27, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<static_local_objects>:
               	leaq	<rip>, %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x20, %rcx
               	andq	$0x1f, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx
               	addq	$0x10, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movl	$0x2, %ecx
               	movl	%ecx, (%rdx)
               	leaq	<rip>, %rcx
               	movl	$0x3, %esi
               	movl	%esi, 0x20(%rcx)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edi
               	movl	%edi, 0x10(%rsi)
               	movslq	(%rax), %rax
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rax
               	movslq	0x20(%rcx), %rcx
               	addq	%rcx, %rax
               	addq	$0x4, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1b, %eax
               	retq
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	retq
               	xorq	%rax, %rax
               	retq

<automatic_objects>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	movl	$0x2, %eax
               	movb	%al, -0x18(%rbp)
               	leaq	0x20(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	movl	$0x3, %eax
               	movb	%al, -0x30(%rbp)
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	popq	%rcx
               	movq	%rdi, %rax
               	movl	$0x4, %eax
               	movb	%al, -0x58(%rbp)
               	leaq	0x30(%rsp), %rax
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
               	popq	%rdx
               	movq	%rax, %rcx
               	movl	$0x5, %ecx
               	movb	%cl, -0x80(%rbp)
               	leaq	0x50(%rsp), %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rcx)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rcx)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rcx)
               	popq	%rax
               	leaq	0x80(%rsp), %rcx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movq	%rcx, %r8
               	andq	$0x7, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1d, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rsi, %rdx
               	andq	$0xf, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rdi, %rdx
               	andq	$0x1f, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x10, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	leaq	0x50(%rsp), %rax
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	testl	%edx, %edx
               	setne	%dl
               	movzbq	%dl, %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x10, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x8(%rbp), %rax
               	movsbq	-0x18(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x30(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x58(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x80(%rbp), %rcx
               	addq	%rcx, %rax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0xf0(%rbp), %rsp
               	leave
               	retq

<by_value>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x90(%rbp)
               	movq	%rsi, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	%dil, %rdi
               	movb	%dil, -0x90(%rbp)
               	leaq	0x20(%rsp), %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	(%rsp), %rdx
               	movq	%rdx, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	leaq	0x30(%rsp), %rax
               	movq	%rax, %rsi
               	andq	$0xf, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	leaq	0x10(%rax), %rsi
               	andq	$0xf, %rsi
               	testl	%esi, %esi
               	setne	%sil
               	movzbq	%sil, %rsi
               	movslq	%esi, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x27, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	movsbq	-0x90(%rbp), %rsi
               	movslq	0x4(%rcx), %rcx
               	addq	%rsi, %rcx
               	movslq	0x14(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq
               	xorq	%rax, %rax
               	leaq	-0x90(%rbp), %rsp
               	leave
               	retq

<parameters>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x20(%rsp), %rsi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rsi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rsi)
               	popq	%rcx
               	movq	%rsi, %rax
               	leaq	(%rsp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdx)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rax
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	movq	0x10(%rax), %rdx
               	movq	%rdx, 0x10(%rcx)
               	movq	0x18(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	movl	$0x1, %edi
               	subq	$0x40, %rsp
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rcx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x8(%rsi), %rdx
               	movq	(%rsi), %rsi
               	callq	<addr>
               	addq	$0x40, %rsp
               	movslq	%eax, %rax
               	leaq	-0x70(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
