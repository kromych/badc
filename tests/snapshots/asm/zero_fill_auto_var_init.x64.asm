
zero_fill_auto_var_init.x64:	file format elf64-x86-64

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

<uninit_64>:
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

<uninit_256>:
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

<uninit_264>:
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

<uninit_4k>:
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

<uninit_64k>:
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

<uninit_vla>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	movq	%rdi, %rax
               	shlq	$0x3, %rax
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	addq	$0x7, %rax
               	andq	$-0x8, %rax
               	leaq	(%rcx,%rax), %rdx
               	movq	%rcx, %rax
               	cmpq	%rdx, %rax
               	jae	<addr>
               	movq	$0x0, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	-0x20(%rbp), %rsi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rsi, (%rcx,%rdx,8)
               	movq	(%rcx), %rax
               	leaq	-0x1(%rdi), %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	addq	%rcx, %rax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x3, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x64, %edi
               	movl	$0x3, %esi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
