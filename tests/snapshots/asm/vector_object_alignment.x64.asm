
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
               	jmp	<addr>
               	jmp	<addr>

<static_local_objects>:
               	leaq	<rip>, %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x20, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	retq
               	leaq	<rip>, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	addq	$0x10, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	retq
               	movl	$0x1, %eax
               	movl	%eax, (%rcx)
               	leaq	<rip>, %rdx
               	movl	$0x2, %eax
               	movl	%eax, (%rdx)
               	leaq	<rip>, %rax
               	movl	$0x3, %esi
               	movl	%esi, 0x20(%rax)
               	leaq	<rip>, %rsi
               	movl	$0x4, %edi
               	movl	%edi, 0x10(%rsi)
               	movslq	(%rcx), %rcx
               	movslq	(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x20(%rax), %rax
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
               	jmp	<addr>
               	jmp	<addr>

<automatic_objects>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movl	$0x1, %eax
               	movb	%al, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	movl	$0x2, %ecx
               	movb	%cl, -0x18(%rbp)
               	leaq	0x20(%rsp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	movl	$0x3, %ecx
               	movb	%cl, -0x30(%rbp)
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdi)
               	movq	0x10(%rcx), %rax
               	movq	%rax, 0x10(%rdi)
               	movq	0x18(%rcx), %rax
               	movq	%rax, 0x18(%rdi)
               	popq	%rax
               	movq	%rdi, %rcx
               	movl	$0x4, %ecx
               	movb	%cl, -0x58(%rbp)
               	leaq	0x30(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	movq	%rcx, %rdx
               	movl	$0x5, %edx
               	movb	%dl, -0x80(%rbp)
               	leaq	0x50(%rsp), %rdx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdx)
               	movq	0x10(%r8), %rax
               	movq	%rax, 0x10(%rdx)
               	movq	0x18(%r8), %rax
               	movq	%rax, 0x18(%rdx)
               	movq	0x20(%r8), %rax
               	movq	%rax, 0x20(%rdx)
               	movq	0x28(%r8), %rax
               	movq	%rax, 0x28(%rdx)
               	popq	%rax
               	leaq	0x80(%rsp), %rdx
               	leaq	<rip>, %r8
               	pushq	%rax
               	movq	(%r8), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%r8), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %r8
               	andq	$0x7, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1d, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rsi, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rcx), %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	leaq	0x50(%rsp), %rcx
               	movq	%rcx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rcx), %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
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
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0xf0(%rbp), %rsp
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>

<by_value>:
               	popq	%r10
               	subq	$0x40, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rsi, 0x20(%rsp)
               	movq	%rdx, 0x28(%rsp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x60(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x68(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x70(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x78(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x80(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x88(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movsbq	%dil, %rdi
               	movb	%dil, 0x10(%rbp)
               	leaq	0x20(%rsp), %rdx
               	movq	%rdx, %rax
               	andq	$0xf, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	leaq	-0x70(%rbp), %rsp
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	leaq	(%rsp), %rsi
               	movq	%rsi, %rax
               	andq	$0x1f, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	leaq	-0x70(%rbp), %rsp
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	leaq	0x30(%rsp), %rax
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	0x10(%rax), %rcx
               	andq	$0xf, %rcx
               	testl	%ecx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movslq	%ecx, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x27, %eax
               	leaq	-0x70(%rbp), %rsp
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	movsbq	0x10(%rbp), %rcx
               	movslq	0x4(%rdx), %rdx
               	addq	%rdx, %rcx
               	movslq	0x14(%rsi), %rdx
               	addq	%rdx, %rcx
               	movslq	0x18(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0x11, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	leaq	-0x70(%rbp), %rsp
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	xorq	%rax, %rax
               	leaq	-0x70(%rbp), %rsp
               	addq	$0x70, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x40, %rsp
               	pushq	%r11
               	retq
               	jmp	<addr>

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
               	addq	$0x70, %rsp
               	popq	%rbp
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
