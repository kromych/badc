
gcc_vector_array_whole_value_init.x64:	file format elf64-x86-64

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
               	subq	$0x90, %rsp
               	leaq	-0x90(%rbp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x80(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x70(%rbp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	addq	$0x20, %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movzbq	-0x51(%rbp), %rcx
               	cmpl	$0x10, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rdx
               	cmpl	$0x15, %edx
               	jne	<addr>
               	movzbq	0xf(%rcx), %rcx
               	cmpl	$0x24, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	addq	$0x20, %rax
               	movzbq	(%rax), %rcx
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x70(%rbp), %rsi
               	addq	$0x20, %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzbq	-0x51(%rbp), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movzbq	(%rdx), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	0x10(%rax), %rdx
               	movzbq	0xf(%rdx), %rdx
               	cmpl	$0x24, %edx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	addq	$0x20, %rax
               	movzbq	(%rax), %rdx
               	cmpl	$0x29, %edx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x90(%rbp), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x20, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movb	$0x7, -0x60(%rbp)
               	movb	$0x7, -0x5f(%rbp)
               	movb	$0x7, -0x5e(%rbp)
               	movb	$0x7, -0x5d(%rbp)
               	movb	$0x7, -0x5c(%rbp)
               	movb	$0x7, -0x5b(%rbp)
               	movb	$0x7, -0x5a(%rbp)
               	movb	$0x7, -0x59(%rbp)
               	movb	$0x7, -0x58(%rbp)
               	movb	$0x7, -0x57(%rbp)
               	movb	$0x7, -0x56(%rbp)
               	movb	$0x7, -0x55(%rbp)
               	movb	$0x7, -0x54(%rbp)
               	leaq	-0x60(%rbp), %rcx
               	movb	$0x7, -0x53(%rbp)
               	movb	$0x7, -0x52(%rbp)
               	movb	$0x7, -0x51(%rbp)
               	leaq	-0x80(%rbp), %rdx
               	leaq	0x10(%rcx), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	movzbq	-0x51(%rbp), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movzbq	(%rax), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	addq	$0x10, %rax
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movb	$0x3, -0x60(%rbp)
               	movb	$0x3, -0x5f(%rbp)
               	movb	$0x3, -0x5e(%rbp)
               	movb	$0x3, -0x5d(%rbp)
               	movb	$0x3, -0x5c(%rbp)
               	movb	$0x3, -0x5b(%rbp)
               	movb	$0x3, -0x5a(%rbp)
               	movb	$0x3, -0x59(%rbp)
               	movb	$0x3, -0x58(%rbp)
               	movb	$0x3, -0x57(%rbp)
               	movb	$0x3, -0x56(%rbp)
               	movb	$0x3, -0x55(%rbp)
               	movb	$0x3, -0x54(%rbp)
               	leaq	-0x60(%rbp), %rdx
               	movb	$0x3, -0x53(%rbp)
               	movb	$0x3, -0x52(%rbp)
               	movb	$0x3, -0x51(%rbp)
               	leaq	-0x90(%rbp), %rcx
               	leaq	0x10(%rdx), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x59(%rbp), %rdx
               	cmpl	$0x3, %edx
               	jne	<addr>
               	movzbq	0x7(%rax), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	0x20(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x80(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x15, %eax
               	jne	<addr>
               	movzbq	(%rdx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	leaq	-0x70(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movzbq	0x9(%rcx), %rax
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movzbq	0xf(%rdx), %rax
               	cmpl	$0x38, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rdx
               	leaq	0x10(%rax), %rsi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	-0x70(%rbp), %rsi
               	leaq	0x20(%rax), %rdi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rdi)
               	addq	$0x30, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	leaq	0x10(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x15, %ecx
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	leaq	0x20(%rax), %rcx
               	movzbq	(%rcx), %rcx
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	addq	$0x30, %rax
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x10, %eax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	leaq	-0x90(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x10(%rax), %rcx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rax), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	-0x70(%rbp), %rcx
               	addq	$0x30, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x60(%rbp), %rax
               	leaq	0x40(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x90(%rbp), %rcx
               	leaq	0x50(%rax), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	movzbq	-0x60(%rbp), %rsi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	leaq	0x20(%rax), %rsi
               	movzbq	(%rsi), %rsi
               	cmpl	$0x29, %esi
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	addq	$0x30, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movzbq	(%rdx), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x5, -0x50(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	addq	$0x20, %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x6, -0x30(%rbp)
               	movzbq	-0x60(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	addq	$0x20, %rax
               	movzbq	0xf(%rax), %rax
               	cmpl	$0x24, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x10, %rax
               	movzbq	(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x17, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x16, %eax
               	leave
               	retq
