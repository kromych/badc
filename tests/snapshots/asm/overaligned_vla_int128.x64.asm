
overaligned_vla_int128.x64:	file format elf64-x86-64

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

<fixed_beside_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x3, %edx
               	movl	$0xc, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movq	%rdx, -0x18(%rbp)
               	movq	-0x18(%rbp), %rsi
               	leaq	-0x40(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	sarq	$0x3f, %rsi
               	movq	%rsi, 0x8(%rcx)
               	leaq	-0x50(%rbp), %rsi
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	movq	%rsi, %rcx
               	leaq	-0x50(%rbp), %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	orq	$0x1, %rsi
               	movl	%esi, (%rcx)
               	movl	%edx, (%rax)
               	movl	$0x6, %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x50(%rbp), %rcx
               	movq	(%rcx), %rsi
               	movq	0x8(%rcx), %rdi
               	movslq	(%rax), %r8
               	movslq	%edx, %rax
               	addq	%r8, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	sarq	$0x3f, %rdx
               	addq	%rsi, %rax
               	cmpq	%rsi, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	movq	%rax, (%rcx)
               	movq	%rdx, 0x8(%rcx)
               	leaq	-0x50(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<int128_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x2, %esi
               	movl	$0x20, %eax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	movq	%rax, %rcx
               	andq	$0xf, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rdx
               	orq	$0x2, %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x28(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rdx, %rdx
               	movq	%rdx, 0x8(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	leaq	0x10(%rax), %rdx
               	movl	$0x6, %esi
               	leaq	-0x38(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	xorq	%rsi, %rsi
               	movq	%rsi, 0x8(%rcx)
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rdx)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rdx)
               	popq	%rax
               	movq	%rdx, %rcx
               	movq	(%rax), %rcx
               	addq	$0x10, %rax
               	movq	(%rax), %rsi
               	leaq	(%rcx,%rsi), %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x3, %edi
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	popq	%rbp
               	retq
