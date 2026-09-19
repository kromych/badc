
zero_fill_sizes.x64:	file format elf64-x86-64

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

<local_64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x40(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movq	%rdi, %rcx
               	andq	$0x7, %rcx
               	movq	%rdi, (%rax,%rcx,8)
               	movq	(%rax), %rcx
               	movq	0x38(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<local_256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	leaq	-0x100(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movq	%rdi, %rcx
               	andq	$0x1f, %rcx
               	movq	%rdi, (%rax,%rcx,8)
               	movq	(%rax), %rcx
               	movq	0xf8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<local_264>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x110, %rsp            # imm = 0x110
               	leaq	-0x108(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	%xmm14, 0x20(%rcx)
               	movups	%xmm14, 0x30(%rcx)
               	movups	%xmm14, 0x40(%rcx)
               	movups	%xmm14, 0x50(%rcx)
               	movups	%xmm14, 0x60(%rcx)
               	movups	%xmm14, 0x70(%rcx)
               	movups	%xmm14, 0x80(%rcx)
               	movups	%xmm14, 0x90(%rcx)
               	movups	%xmm14, 0xa0(%rcx)
               	movups	%xmm14, 0xb0(%rcx)
               	movups	%xmm14, 0xc0(%rcx)
               	movups	%xmm14, 0xd0(%rcx)
               	movups	%xmm14, 0xe0(%rcx)
               	movups	%xmm14, 0xf0(%rcx)
               	movq	$0x0, 0x100(%rcx)
               	movabsq	$0xf83e0f83e0f83e1, %rsi # imm = 0xF83E0F83E0F83E1
               	movq	%rdi, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	shrq	%rax
               	imulq	$0x21, %rax, %rax
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movq	%rdi, (%rcx,%rdx,8)
               	movq	(%rcx), %rax
               	movq	0x100(%rcx), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<local_4k>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	leaq	-0x1000(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movq	%rax, %r10
               	leaq	0x1000(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movq	%rdi, %rcx
               	andq	$0x1ff, %rcx            # imm = 0x1FF
               	movq	%rdi, (%rax,%rcx,8)
               	movq	(%rax), %rcx
               	movq	0xff8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<local_64k>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x10, %r11d
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	leaq	-0x10000(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movq	%rax, %r10
               	leaq	0x10000(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movq	%rdi, %rcx
               	andq	$0x1fff, %rcx           # imm = 0x1FFF
               	movq	%rdi, (%rax,%rcx,8)
               	movq	(%rax), %rcx
               	addq	$0xfff8, %rax           # imm = 0xFFF8
               	movq	(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<local_odd>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	leaq	-0xff8(%rbp), %rcx
               	xorps	%xmm14, %xmm14
               	movq	%rcx, %r10
               	leaq	0xff0(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movl	$0x0, (%r10)
               	movabsq	$0xc0906c513cedb3, %rsi # imm = 0xC0906C513CEDB3
               	movq	%rdi, %rax
               	mulq	%rsi
               	movq	%rdi, %rax
               	subq	%rdx, %rax
               	shrq	%rax
               	addq	%rdx, %rax
               	shrq	$0x9, %rax
               	imulq	$0x3fd, %rax, %rax      # imm = 0x3FD
               	movq	%rdi, %rdx
               	subq	%rax, %rdx
               	movl	%edi, (%rcx,%rdx,4)
               	movslq	(%rcx), %rax
               	movslq	0xff0(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	leave
               	retq

<zero_264>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	movups	%xmm14, 0x60(%rdi)
               	movups	%xmm14, 0x70(%rdi)
               	movups	%xmm14, 0x80(%rdi)
               	movups	%xmm14, 0x90(%rdi)
               	movups	%xmm14, 0xa0(%rdi)
               	movups	%xmm14, 0xb0(%rdi)
               	movups	%xmm14, 0xc0(%rdi)
               	movups	%xmm14, 0xd0(%rdi)
               	movups	%xmm14, 0xe0(%rdi)
               	movups	%xmm14, 0xf0(%rdi)
               	movq	$0x0, 0x100(%rdi)
               	retq

<zero_4k>:
               	xorps	%xmm14, %xmm14
               	movq	%rdi, %r10
               	leaq	0x1000(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	retq

<zero_odd>:
               	xorps	%xmm14, %xmm14
               	movq	%rdi, %r10
               	leaq	0xff0(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movl	$0x0, (%r10)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movq	$0x1, 0x100(%rbx)
               	leaq	<rip>, %r12
               	movq	$0x1, 0xff8(%r12)
               	leaq	<rip>, %r13
               	movl	$0x1, 0xff0(%r13)
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rbx)
               	movups	%xmm14, 0x10(%rbx)
               	movups	%xmm14, 0x20(%rbx)
               	movups	%xmm14, 0x30(%rbx)
               	movups	%xmm14, 0x40(%rbx)
               	movups	%xmm14, 0x50(%rbx)
               	movups	%xmm14, 0x60(%rbx)
               	movups	%xmm14, 0x70(%rbx)
               	movups	%xmm14, 0x80(%rbx)
               	movups	%xmm14, 0x90(%rbx)
               	movups	%xmm14, 0xa0(%rbx)
               	movups	%xmm14, 0xb0(%rbx)
               	movups	%xmm14, 0xc0(%rbx)
               	movups	%xmm14, 0xd0(%rbx)
               	movups	%xmm14, 0xe0(%rbx)
               	movups	%xmm14, 0xf0(%rbx)
               	movq	$0x0, 0x100(%rbx)
               	xorps	%xmm14, %xmm14
               	movq	%r12, %r10
               	leaq	0x1000(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	xorps	%xmm14, %xmm14
               	movq	%r13, %r10
               	leaq	0xff0(%r10), %r11
               	movups	%xmm14, (%r10)
               	addq	$0x10, %r10
               	cmpq	%r11, %r10
               	jb	<addr>
               	movl	$0x0, (%r10)
               	movl	$0x3, %r14d
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%rax, %r15
               	movq	%r14, %rdi
               	callq	<addr>
               	addq	%r15, %rax
               	movq	0x100(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	0xff8(%r12), %rcx
               	addq	%rcx, %rax
               	movslq	0xff0(%r13), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
