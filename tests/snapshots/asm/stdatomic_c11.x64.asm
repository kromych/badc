
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
               	movl	$0x5, %edx
               	movl	%edx, (%rcx)
               	movslq	%edx, %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xa, %esi
               	pushq	%rax
               	movq	%rcx, %r11
               	movq	%rsi, %r10
               	movq	%r10, %rax
               	lock
               	xaddl	%eax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rsi
               	cmpl	$0x5, %esi
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	-0x28(%rbp), %rsi
               	cmpl	$0xf, %esi
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xf, %esi
               	movl	%esi, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x63, %edi
               	pushq	%rax
               	pushq	%rcx
               	movq	%rcx, %r11
               	movq	%rdi, %r10
               	movq	%rsi, %rcx
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
               	movq	%rdx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rdx
               	movb	%al, (%rdx)
               	movl	$0x1, %ecx
               	movq	%rdx, %r11
               	movq	%rcx, %r10
               	xchgb	%r10b, (%r11)
               	movq	%r10, %rsi
               	movsbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movb	%al, (%rdx)
               	movl	%eax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movl	$0x2a, %eax
               	movl	%eax, (%rdx)
               	movslq	%eax, %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x10(%rbp), %rax
               	movl	$0x64, %edx
               	movq	%rdx, (%rax)
               	pushq	%rax
               	movq	%rax, %r11
               	movq	%rcx, %r10
               	movq	%r10, %rax
               	lock
               	xaddq	%rax, (%r11)
               	movq	%rax, %r10
               	popq	%rax
               	movq	%r10, %rdx
               	movq	(%rax), %rdx
               	cmpq	$0x65, %rdx
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	%ecx, 0x8(%rax)
               	movslq	%ecx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
