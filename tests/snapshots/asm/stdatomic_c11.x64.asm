
stdatomic_c11.x64:	file format elf64-x86-64

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
               	xorq	%rax, %rax
               	movl	%eax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movl	$0x5, %esi
               	movl	%esi, (%rcx)
               	movl	$0xa, %edx
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	cmpl	$0x5, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x28(%rbp), %rdx
               	cmpl	$0xf, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %edx
               	movl	%edx, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rdx
               	movl	$0x63, %edi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdi, %r10
               	movq	%rdx, %rcx
               	movl	(%rcx), %eax
               	lock
               	cmpxchgl	%r10d, (%r11)
               	je	<addr>
               	movl	%eax, (%rcx)
               	sete	%r11b
               	movzbq	%r11b, %r11
               	popq	%rcx
               	popq	%rax
               	movq	%r11, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x28(%rbp), %rcx
               	cmpl	$0x63, %ecx
               	je	<addr>
               	movq	%rsi, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rcx
               	movb	%al, (%rcx)
               	movl	$0x1, %edx
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rsi
               	movsbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movb	%al, (%rcx)
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movl	$0x2a, %esi
               	movl	%esi, (%rcx)
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x64, %esi
               	movq	%rsi, (%rcx)
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rdx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rsi
               	movq	(%rcx), %rsi
               	cmpq	$0x65, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%edx, 0x8(%rcx)
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
