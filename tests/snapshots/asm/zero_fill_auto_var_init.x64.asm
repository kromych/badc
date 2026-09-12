
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
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
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
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	movq	%rcx, 0x18(%rax)
               	movq	%rcx, 0x20(%rax)
               	movq	%rcx, 0x28(%rax)
               	movq	%rcx, 0x30(%rax)
               	movq	%rcx, 0x38(%rax)
               	movq	%rcx, 0x40(%rax)
               	movq	%rcx, 0x48(%rax)
               	movq	%rcx, 0x50(%rax)
               	movq	%rcx, 0x58(%rax)
               	movq	%rcx, 0x60(%rax)
               	movq	%rcx, 0x68(%rax)
               	movq	%rcx, 0x70(%rax)
               	movq	%rcx, 0x78(%rax)
               	movq	%rcx, 0x80(%rax)
               	movq	%rcx, 0x88(%rax)
               	movq	%rcx, 0x90(%rax)
               	movq	%rcx, 0x98(%rax)
               	movq	%rcx, 0xa0(%rax)
               	movq	%rcx, 0xa8(%rax)
               	movq	%rcx, 0xb0(%rax)
               	movq	%rcx, 0xb8(%rax)
               	movq	%rcx, 0xc0(%rax)
               	movq	%rcx, 0xc8(%rax)
               	movq	%rcx, 0xd0(%rax)
               	movq	%rcx, 0xd8(%rax)
               	movq	%rcx, 0xe0(%rax)
               	movq	%rcx, 0xe8(%rax)
               	movq	%rcx, 0xf0(%rax)
               	movq	%rcx, 0xf8(%rax)
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
               	leaq	-0x108(%rbp), %rax
               	leaq	0x108(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	-0x108(%rbp), %rax
               	movabsq	$0xf83e0f83e0f83e1, %rcx # imm = 0xF83E0F83E0F83E1
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	mulq	%rcx
               	movq	%rdx, %rcx
               	popq	%rdx
               	popq	%rax
               	shrq	%rcx
               	imulq	$0x21, %rcx, %rcx
               	movq	%rcx, %r10
               	movq	%rdi, %rcx
               	subq	%r10, %rcx
               	movq	%rdi, (%rax,%rcx,8)
               	movq	(%rax), %rcx
               	movq	0x100(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<uninit_4k>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x10, %rsp
               	leaq	-0x1000(%rbp), %rax
               	leaq	0x1000(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	-0x1000(%rbp), %rax
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
               	subq	$0x10, %rsp
               	leaq	-0x10000(%rbp), %rax
               	leaq	0x10000(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	-0x10000(%rbp), %rax
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
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rdx, %rax
               	jb	<addr>
               	movq	-0x20(%rbp), %rax
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rdi
               	popq	%rax
               	movq	%rax, (%rcx,%rdx,8)
               	movq	(%rcx), %rdx
               	leaq	-0x1(%rdi), %rax
               	movq	(%rcx,%rax,8), %rax
               	addq	%rdx, %rax
               	leaq	-0x30(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x3, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	(%rax), %rsi
               	leaq	-0x108(%rbp), %rax
               	leaq	0x108(%rax), %rcx
               	jmp	<addr>
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	addq	$0x8, %rax
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	-0x108(%rbp), %rax
               	movq	%rbx, 0x18(%rax)
               	movq	(%rax), %rcx
               	movq	0x100(%rax), %rax
               	addq	%rcx, %rax
               	leaq	(%rsi,%rax), %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	movl	$0x64, %edi
               	movq	%rbx, %rsi
               	callq	<addr>
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	leave
               	retq
